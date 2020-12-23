import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/widgets/cart_item.dart';
import 'package:pizzard/widgets/checkoutbtn.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool darkThemeEnabled;
  CartScreen({this.darkThemeEnabled});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: cart.items.length != 0
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 5,
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      "<<<  Swipe left to remove item from cart",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) => CartPdt(
                        id: cart.items.values.toList()[index].id,
                        // index: cart.items.keys.toList()[index],
                        price: cart.items.values.toList()[index].price,
                        loadedQuantity:
                            cart.items.values.toList()[index].quantity,
                        name: cart.items.values.toList()[index].name,
                        image: cart.items.values.toList()[index].image,
                        productQty:
                            cart.items.values.toList()[index].productQty,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text('Your Cart items show up here'),
            ),
      floatingActionButton:
          cart.items.length != 0 ? CheckOutButton(cart: cart) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
