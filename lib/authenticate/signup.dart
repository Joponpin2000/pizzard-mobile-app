import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;
  final bool darkThemeEnabled;
  final bool redirectToOrder;

  SignUpScreen({this.toggleView, this.darkThemeEnabled, this.redirectToOrder});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  final _key = GlobalKey<FormState>();

  String error = '';
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                        'Create new account.',
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
                              decoration: InputDecoration(hintText: 'Username'),
                              obscureText: true,
                              controller: usernameController,
                              validator: (value) => value == ''
                                  ? 'Username can\'t be empty'
                                  : null,
                            ),
                            SizedBox(height: 10),
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
                            SizedBox(height: 10),
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
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Register',
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
                            children: <Widget>[
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.toggleView,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
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
              ),
            ),
    );
  }
}
