import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/check.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/screens/Shipping.dart';

class CheckOutButton extends StatefulWidget {
  final Cart cart;
  const CheckOutButton({@required this.cart});

  @override
  _CheckOutButtonState createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
        child: FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            onPressed: widget.cart.totalAmount <= 0
                ? null
                : () async {
                    Future userIsLoggedIn = check();
                    if (userIsLoggedIn != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShippingScreen(cart: widget.cart),
                        ),
                      );
                    }
                  }),
      ),
    );
  }
}
