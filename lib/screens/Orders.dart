import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/models/orders.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List _orders = [];
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final orderInstance = Provider.of<Orders>(context);
    setState(() {
      _orders = orderInstance.orders;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        top: true,
        child: _loaded
            ? _orders.isEmpty
                ? Center(
                    child: Text("Your Ordered items show up here"),
                  )
                : SafeArea(
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
                            itemCount: _orders.length,
                            itemBuilder: (context, index) => OrderPdt(
                              id: _orders[index].id,
                              price: _orders[index].price,
                              loadedQuantity: _orders[index].quantity,
                              name: _orders[index].name,
                              image: _orders[index].image,
                              productQty: _orders[index].productQty,
                              cartPage: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}