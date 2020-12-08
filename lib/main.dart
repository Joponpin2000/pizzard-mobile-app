import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/models/orders.dart';
import 'package:pizzard/screens/Cart.dart';
import 'package:pizzard/screens/Search.dart';
import 'package:pizzard/screens/Settings.dart';
import 'package:pizzard/screens/home.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Foods(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: DynamicTheme(
        data: (brightness) {
          return ThemeData(
            primaryColor: Colors.orangeAccent,
            accentColor: Colors.blueGrey[900],
            fontFamily: 'Circular',
            brightness: brightness == Brightness.dark
                ? Brightness.dark
                : Brightness.light,
            scaffoldBackgroundColor: brightness == Brightness.dark
                ? Colors.blueGrey[900]
                : Colors.white,
          );
        },
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: userIsLoggedIn ? MainScreen() : Authenticate(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int i = 0;
  var pages = [
    new HomeScreen(),
    new SearchScreen(),
    new CartScreen(),
    new SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pages[i],
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: i,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "Cart",
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
