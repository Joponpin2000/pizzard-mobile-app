import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/widgets/cart_item.dart';
import 'package:pizzard/widgets/drawer.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final bool darkThemeEnabled;
  CartScreen({this.darkThemeEnabled});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: MyDrawerWidget(
        darkThemeEnabled: darkThemeEnabled,
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
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => CartPdt(
                id: cart.items.values.toList()[index].id,
                // index: cart.items.keys.toList()[index],
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                name: cart.items.values.toList()[index].name,
              ),
            ),
          ),
          // CheckOutButton(cart: cart),
          // FlatButton(
          //   onPressed: () {

          //   },
          //   child: Text(
          //     'Checkout',
          //     style: TextStyle(
          //       color: Colors.blue,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
