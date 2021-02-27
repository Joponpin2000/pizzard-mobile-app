// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pizzard/main.dart';
// import 'package:pizzard/models/orders.dart';
// import 'package:pizzard/widgets/order_item.dart';
// import 'package:provider/provider.dart';

// class OrdersScreen extends StatefulWidget {
//   final String snackbarMsg;
//   final String reference;
//   OrdersScreen({this.snackbarMsg, this.reference});
//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   List _orders = [];
//   bool _loaded = false;
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   DateTime dateTime;

//   @override
//   void initState() {
//     if (widget.reference != null && widget.snackbarMsg != null) {
//       dateTime = DateTime.now();
//       _updateStatus(widget.reference, widget.snackbarMsg);
//     }
//     super.initState();
//   }

//   _updateStatus(String reference, String message) {
//     showToast('$message', Colors.greenAccent);
//   }

//   void showToast(message, color) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderInstance = Provider.of<Orders>(context);
//     setState(() {
//       _orders = orderInstance.orders;
//       _loaded = true;
//     });
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MainScreen(),
//               ),
//             );
//           },
//         ),
//         title: Text("Orders"),
//       ),
//       body: SafeArea(
//         top: true,
//         child: _loaded
//             ? _orders.isEmpty
//                 ? Center(
//                     child: Text("Your Ordered items show up here"),
//                   )
//                 : SafeArea(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           child: Text(
//                             "Summary",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: _orders.length,
//                             itemBuilder: (context, index) => OrderPdt(
//                               id: _orders[index].id,
//                               price: _orders[index].price,
//                               loadedQuantity: _orders[index].quantity,
//                               name: _orders[index].name,
//                               image: _orders[index].image,
//                               productQty: _orders[index].productQty,
//                               cartPage: false,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//             : Center(
//                 child: Container(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//       ),
//     );
//   }
// }
