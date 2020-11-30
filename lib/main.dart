import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/screens/home.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/widgets/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  var payload;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getJwtSharedPreference().then((value) => {
          if (value != null)
            {
              payload = parseJwt(value),
              if (validateJwt(payload))
                {
                  setState(
                    () {
                      userIsLoggedIn = true;
                    },
                  ),
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
        theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        title: 'Pizzards',
        home: userIsLoggedIn
            ? HomeScreen(snapshot.data)
            : Authenticate(snapshot.data),
      ),
    );
  }
}
