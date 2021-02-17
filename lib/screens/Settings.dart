import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:pizzard/main.dart';
import 'package:pizzard/screens/AppInfo.dart';
import 'package:pizzard/screens/Orders.dart';
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
            SizedBox(height: 20),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.color_lens,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                ),
                title: Text('Dark Theme'),
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.light
                      ? false
                      : true,
                  onChanged: (value) {
                    DynamicTheme.of(context).setBrightness(
                      value ? Brightness.dark : Brightness.light,
                    );
                    saveDarkTheme();
                  },
                ),
              ),
            ),
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              height: 0.1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                builder: (context) => OrdersScreen(),
                  ),
                );
              },
              child: Container(
                child: ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                  ),
                  title: Text('Orders'),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              height: 0.1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppInfoScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                  ),
                  title: Text('App info'),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              height: 0.1,
            ),
            SizedBox(height: 10),
            _logout
                ? GestureDetector(
                    onTap: () async {
                      signOut();
                    },
                    child: Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                        ),
                        title: Text('Logout'),
                      ),
                    ),
                  )
                : Container(),
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              height: 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
