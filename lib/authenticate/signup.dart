import 'package:flutter/material.dart';
import 'package:pizzard/services/auth.dart';
import 'package:shape_of_view/shape_of_view.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;
  final bool redirectToOrder;

  SignUpScreen({this.toggleView, this.redirectToOrder});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  final _key = GlobalKey<FormState>();

  String error = '';
  String message = '';
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signup() async {
    if (_key.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await attemptSignUp(usernameController.text.trim(), emailController.text.trim(),
              passwordController.text)
          .then(
        (res) async {
          if (res[0]["successMessage"] != null &&
              res[0]["successMessage"] != "") {
            setState(() {
              isLoading = false;
              error = '';
              message = res[0]["successMessage"];
            });
          } else {
            setState(() {
              isLoading = false;
              message = '';
              error = res[0]["errorMessage"];
            });
          }
        },
      );
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
          : SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                    //   shape: StarShape(
                    //     noOfPoints: 11,
                    //   ),
                      // shape: ArcShape(
                      //   direction: ArcDirection.Outside,
                      //   height: 20,
                      //   position: ArcPosition.Bottom,
                      // ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image(
                        image: AssetImage(
                          "assets/sign.png",
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          message != ''
                              ? Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    message,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                )
                              : error != ''
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        error,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  : Container(),
                          SizedBox(height: 5),
                          Form(
                            key: _key,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Username'),
                                  obscureText: true,
                                  controller: usernameController,
                                  validator: (value) => value == ''
                                      ? 'Username can\'t be empty'
                                      : null,
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Email'),
                                  controller: emailController,
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val)
                                        ? null
                                        : "Please provide a valid Email";
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: (value) => value.length < 6
                                      ? 'Password should be 6+ chars long'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              signup();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Already have an account?',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.toggleView,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
