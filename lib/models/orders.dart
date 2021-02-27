import 'package:flutter/foundation.dart';

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
  List _orders = [];

  List get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double total, String reference) async {
    HelperFunctions.saveOrdersSharedPreference(reference);
    _orders = cartProducts;
    notifyListeners();
    return orders;
  }
}
