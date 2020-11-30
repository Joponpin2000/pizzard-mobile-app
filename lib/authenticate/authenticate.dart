import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/login.dart';
import 'package:pizzard/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  final bool darkThemeEnabled;
  Authenticate(this.darkThemeEnabled);
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
        darkThemeEnabled: widget.darkThemeEnabled,
      );
    } else {
      return SignUpScreen(
        toggleView: toggleView,
        darkThemeEnabled: widget.darkThemeEnabled,
      );
    }
  }
}
