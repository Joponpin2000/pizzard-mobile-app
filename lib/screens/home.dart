import 'package:flutter/material.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/widgets/food_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods;
  bool _loading = true;

  getFoods(items) {
    if (this.mounted) {
      if (items != null && items != []) {
        setState(() {
          _loading = false;
          foods = items;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Foods>(context);
    productData.getFoodsFromServer().then((value) => getFoods(value));

    return Scaffold(
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 5,
                        left: 15,
                        right: 15,
                      ),
                      child: Text(
                        "What would you like",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Text(
                        "to eat?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: FoodList(
                        foods: foods,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
