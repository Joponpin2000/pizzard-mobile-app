import 'package:flutter/material.dart';
import 'package:pizzard/models/food.dart';
import 'package:pizzard/models/response.dart';
import 'package:pizzard/services/foods.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods = List<FoodModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getFoods();
  }

  getFoods() async {
    Foods foodClass = Foods();
    await foodClass.getFoodsFromServer();
    foods = Products().foods;
    setState(() {
      _loading = false;
    });
    print(foods);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
