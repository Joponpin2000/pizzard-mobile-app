// import 'package:flutter/material.dart';
// import 'package:pizzard/authenticate/check.dart';
// import 'package:pizzard/models/cart.dart';
// import 'package:pizzard/models/orders.dart';
// import 'package:provider/provider.dart';

// class PlaceOrderButton extends StatefulWidget {
//   final Cart cart;
//   const PlaceOrderButton({@required this.cart});

//   @override
//   _PlaceOrderButtonState createState() => _PlaceOrderButtonState();
// }

// class _PlaceOrderButtonState extends State<PlaceOrderButton> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.width * 0.2,
//       width: MediaQuery.of(context).size.width,
//       child: FittedBox(
//         child: FlatButton(
//             color: Theme.of(context).primaryColor,
//             child: Text(
//               'PlaceOrder',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//             onPressed: widget.cart.totalAmount <= 0
//                 ? null
//                 : () async {
//                     Future userIsLoggedIn = check();
//                     if (userIsLoggedIn != null) {
//                       await Provider.of<Orders>(context, listen: false)
//                           .addOrder(widget.cart.items.values.toList(),
//                               widget.cart.totalAmount);
//                       // widget.cart.clear();
//                     }
//                   }),
//       ),
//     );
//   }
// }
