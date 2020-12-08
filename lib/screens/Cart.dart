import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/widgets/cart_item.dart';
import 'package:pizzard/widgets/checkoutbtn.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final bool darkThemeEnabled;
  CartScreen({this.darkThemeEnabled});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: cart.items.length != 0
          ? SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 5),
                    child: Text(
                      "<<<<<  Swipe left to remove item from cart",
                      style: TextStyle(
                        color: Colors.orangeAccent,
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
                        quantity: cart.items.values.toList()[index].quantity,
                        name: cart.items.values.toList()[index].name,
                        image: cart.items.values.toList()[index].image,
                      ),
                    ),
                  ),
                  CheckOutButton(cart: cart),
                ],
              ),
            )
          : Center(
              child: Text('Your Cart items show up here'),
            ),
    );
  }
}
