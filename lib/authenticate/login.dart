import 'package:flutter/material.dart';
import 'package:pizzard/screens/home.dart';
import 'package:pizzard/services/auth.dart';
import 'package:pizzard/shared/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;

  LoginScreen({this.toggleView});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _key = GlobalKey<FormState>();

  String error = '';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  login() async {
    if (_key.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await attemptLogin(emailController.text, passwordController.text)
          .then((res) async {
        setState(() {
          isLoading = false;
        });
        if (res != null) {
          if (await HelperFunctions.saveJwtSharedPreference(res.token) !=
              null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else {
            AlertDialog(
              title: Text('Error'),
              content: Text('Please try again'),
            );
          }
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
          : SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Hello.',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 12),
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
                            SizedBox(height: 30),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) => value.length < 6
                                  ? 'Password should be 6+ chars long'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
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
                            'Login',
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
