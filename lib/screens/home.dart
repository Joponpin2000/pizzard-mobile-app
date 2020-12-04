import 'package:flutter/material.dart';
import 'package:pizzard/screens/Cart.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/widgets/drawer.dart';
import 'package:pizzard/widgets/food_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool darkThemeEnabled;
  HomeScreen(this.darkThemeEnabled);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    // getFoods();
  }

  getFoods(items) async {
    if (items != null && items != []) {
      setState(() {
        _loading = false;
        foods = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Foods>(context);

    productData.getFoodsFromServer().then((value) => getFoods(value));
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                        darkThemeEnabled: widget.darkThemeEnabled,
                        ),
                  ),
                );
              }),
        ],
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Text(
                      "Popular",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                      darkThemeEnabled: widget.darkThemeEnabled,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
