import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:pizzard/main.dart';
import 'package:pizzard/shared/helper_functions.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _logout = false;

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  saveDarkTheme() async {
    await HelperFunctions.saveDarkThemeSharedPreference(
        Theme.of(context).brightness == Brightness.light ? true : false);
  }

  checkStatus() async {
    final token = await getJwtToken();
    if (token != null) {
      setState(() {
        _logout = true;
      });
    }
  }

  Future signOut() async {
    await HelperFunctions.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Text('Change Theme'),
              trailing: IconButton(
                icon: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.lightbulb_outline
                    : Icons.highlight),
                onPressed: () {
                  DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light,
                  );
                  saveDarkTheme();
                },
              ),
            ),
            _logout
                ? ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        signOut();
                      },
                      child: Text('Logout'),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
