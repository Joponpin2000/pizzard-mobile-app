import 'package:flutter/foundation.dart';

import 'package:pizzard/models/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List _orders = [];

  List get orders {
    return [..._orders];
  }

   addOrder(List<CartItem> cartProducts, double total) async {
    _orders = cartProducts;
    notifyListeners();
    return orders;




    // final token = await getJwtToken();
    // final email = await HelperFunctions.getUserEmailSharedPreference();
    // final name = await HelperFunctions.getUserNameSharedPreference();
    // final url = "$SERVER_IP/api/paystack/pay";
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {"authorization": "Bearer $token"},
    //     body: {
    //       'id': DateTime.now().toString(),

    //       'amount': (total * 100)
    //           .toString(), // multiply amount by 100 as paystack charges in kobo
    //       "email": email,
    //       "name": name,
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     try {
    //       final http.Response pay =
    //           await http.get(jsonDecode(response.body)["url"]);
    //       print(pay.body);
    //     } catch (err) {
    //       throw err;
    //     }

    //     // _orders.insert(
    //     //     0,
    //     //     OrderItem(
    //     //       id: jsonDecode(response.body)['name'],
    //     //       amount: total,
    //     //       dateTime: timeStamp,
    //     //       products: cartProducts,
    //     //     ));
    //   }
    //   notifyListeners();
    // } catch (err) {
    //   throw err;
    // }
  }
}
