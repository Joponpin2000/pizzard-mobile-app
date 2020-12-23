import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
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
  bool brightness;
  var payload;

  @override
  void initState() {
    getDarkThemeState();
    super.initState();
  }

  getDarkThemeState() async {
    await HelperFunctions.getDarkThemeSharedPreference().then((value) => {
          if (value != null)
            {
              setState(
                () {
                  brightness = value;
                },
              ),
            }
          else
            {
              setState(
                () {
                  brightness = false;
                },
              ),
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
            primaryColor: Colors.green,
            accentColor: Colors.greenAccent,
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
            home: MainScreen(),
            title: "Pizzards",
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
    final cart = Provider.of<Cart>(context);
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
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                cart.itemCount > 0
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : SizedBox(),
                Icon(Icons.shopping_cart_outlined,
                    size: 18, color: Colors.grey),
              ],
            ),
            label: "Cart",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
