import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/shared/clip_shadow_path.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class FoodItemScreen extends StatefulWidget {
  final bool darkThemeEnabled;
  final String loadedId;

  FoodItemScreen({this.darkThemeEnabled, this.loadedId});
  @override
  _FoodItemScreenState createState() => _FoodItemScreenState();
}

class _FoodItemScreenState extends State<FoodItemScreen> {
  dynamic food;
  bool _loading = true;

  getFood(item) async {
    if (item != null) {
      setState(() {
        _loading = false;
        food = item;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadedPdt = Provider.of<Foods>(context).findById(widget.loadedId);
    final cart = Provider.of<Cart>(context);
    getFood(loadedPdt);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${food['productName']}"),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      child: Hero(
                          tag: food['productImage'],
                          child: ClipShadowPath(
                            clipper: MiddleClipper(),
                            shadow: Shadow(blurRadius: 20.0),
                            child: Image(
                              height: 200.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "$SERVER_IP/${food['productImage']}",
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      '${food['productName']}',
                    ),
                    subtitle: Text(
                      '${food['productDesc']}',
                    ),
                    trailing: Text('\$${food['productPrice']}'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cart.addItem(
                      food['_id'],
                      food['productName'],
                      food['productPrice'].toDouble(),
                      food['productImage'],
                      food['productQty'],
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
