import 'package:flutter/material.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/widgets/food_list.dart';
import 'package:pizzard/widgets/food_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getFoods();
  }

  getFoods() async {
    Foods foodClass = Foods();
    await foodClass.getFoodsFromServer();

    setState(() {
      _loading = false;
      foods = foodClass.foods;
    });
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
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : FoodList(
                foods: foods,
              ),
    );
  }
}
