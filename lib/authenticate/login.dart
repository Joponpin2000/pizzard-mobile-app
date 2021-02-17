import 'package:flutter/material.dart';
import 'package:pizzard/main.dart';
import 'package:pizzard/screens/Shipping.dart';
import 'package:pizzard/services/auth.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:shape_of_view/shape_of_view.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  final bool redirectToOrder;

  LoginScreen({this.toggleView, this.redirectToOrder});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool _obscureText = true;
  final _key = GlobalKey<FormState>();

  String error = '';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  login() async {
    if (_key.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await attemptLogin(
              emailController.text.trim(), passwordController.text.trim())
          .then((res) async {
        if (res[0]["token"] != null && res[0]["token"] != "") {
          setState(() {
            isLoading = false;
          });
          if (await HelperFunctions.saveJwtSharedPreference(res[0]["token"]) !=
              null) {
            if (widget.redirectToOrder == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ShippingScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            }
          } else {
            AlertDialog(
              title: Text('Error'),
              content: Text('Please try again'),
            );
          }
        } else {
          setState(() {
            isLoading = false;
            error = res[0]["errorMessage"];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ShapeOfView(
                    shape: ArcShape(
                      direction: ArcDirection.Outside,
                      height: 20,
                      position: ArcPosition.Bottom,
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image(
                      image: AssetImage(
                        "assets/log.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        error != null && error.isNotEmpty
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 12,
                                  ),
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: 5),
                        Form(
                          key: _key,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Email'),
                                controller: emailController,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please provide a valid Email";
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),color: Theme.of(context).primaryColor,onPressed: () {
                                      setState(() {
                                        _obscureText  =  !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _obscureText,
                                controller: passwordController,
                                validator: (value) => value.length < 6
                                    ? 'Password should be 6+ chars long'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 15),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: <Widget>[
                        //     Text(
                        //       'Forgot Password?',
                        //       style: TextStyle(
                        //         color: Theme.of(context).primaryColor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            login();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
