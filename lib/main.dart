import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/screens/home.dart';
import 'package:pizzard/shared/helper_functions.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizzards',
      theme: ThemeData(
        primaryColor: Colors.white,
        // accentColor: Colors.grey[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? HomeScreen() : Authenticate(),
      // home: Authenticate(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
