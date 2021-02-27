import 'package:flutter/material.dart';
import 'package:pizzard/screens/Profile.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/widgets/food_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;
  List<dynamic> foods;
  bool _loading = true;

  @override
  void initState() {
    initializeStateValues();
    super.initState();
  }

  initializeStateValues() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
  }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                            bottom: 5,
                            left: 15,
                          ),
                          child: Text(
                            "What would you like",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        email != null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 20,
                                    bottom: 5,
                                    right: 15,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.account_circle_rounded,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
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
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
