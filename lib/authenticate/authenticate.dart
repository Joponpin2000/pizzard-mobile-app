import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/login.dart';
import 'package:pizzard/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  final bool redirectToOrder;

  Authenticate({this.redirectToOrder});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
          toggleView: toggleView,
          redirectToOrder: widget.redirectToOrder == true ? true : false);
    } else {
      return SignUpScreen(
          toggleView: toggleView,
          redirectToOrder: widget.redirectToOrder == true ? true : false);
    }
  }
}
