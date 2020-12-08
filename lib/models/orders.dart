import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pizzard/models/cart.dart';
import 'package:pizzard/shared/helper_functions.dart';

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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final token = await getJwtToken();
    final url = "$SERVER_IP/api/paystack/pay";
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          headers: {"authorization": "Bearer $token"},
          body: json.encode({
            'id': DateTime.now().toString(),
            // multiply amount by 100 as paystack charges in kobo
            'amount': total * 100,
            // email,
            // name
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.name,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList()
          }));
      print(response.body);

      if (response.statusCode == 200) {
        _orders.insert(
            0,
            OrderItem(
              id: jsonDecode(response.body)['name'],
              amount: total,
              dateTime: timeStamp,
              products: cartProducts,
            ));
      }
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
