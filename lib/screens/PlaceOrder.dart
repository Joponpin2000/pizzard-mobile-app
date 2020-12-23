import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/main.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/widgets/order_item.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  var cartInstance;
  bool _loaded = false;
  @override
  void initState() {
    order();
    // PayStackPlugin initialize(publicKey: PUBLIC_KEY);
    super.initState();
  }

  @override
  void dispose() {
    cartInstance.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
    super.dispose();
  }

  order() async {
    final token = await getJwtToken();
    if (token != null) {
      setState(() {
        _loaded = true;
      });
//      final cart = Provider.of<Cart>(context, listen: false);
//
//      await Provider.of<Orders>(context, listen: false)
//          .addOrder(cart.items.values.toList(), cart.totalAmount);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Authenticate(
            redirectToOrder: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    setState(() {
      cartInstance = cart;
    });
    order();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        top: true,
        child: _loaded
            ? SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "Your order has been saved!",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) => OrderPdt(
                          id: cart.items.values.toList()[index].id,
                          // index: cart.items.keys.toList()[index],
                          price: cart.items.values.toList()[index].price,
                          loadedQuantity:
                              cart.items.values.toList()[index].quantity,
                          name: cart.items.values.toList()[index].name,
                          image: cart.items.values.toList()[index].image,
                          productQty:
                              cart.items.values.toList()[index].productQty,
                          cartPage: false,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
