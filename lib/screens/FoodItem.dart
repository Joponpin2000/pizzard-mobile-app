import 'package:flutter/material.dart';
import 'package:pizzard/widgets/drawer.dart';

class FoodItemScreen extends StatefulWidget {
  final bool darkThemeEnabled;
  FoodItemScreen(this.darkThemeEnabled);
  @override
  _FoodItemScreenState createState() => _FoodItemScreenState();
}

class _FoodItemScreenState extends State<FoodItemScreen> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(
        darkThemeEnabled: widget.darkThemeEnabled,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text('Pizzards'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black,
            ),
            onPressed: null,
            // () => of(context).pushNamed(CartScreen.routeName),
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(),
    );
  }
}
