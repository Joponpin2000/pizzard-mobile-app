import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pizzard/shared/helper_functions.dart';

class Foods with ChangeNotifier {
  List<dynamic> foods = [];

  Future<dynamic> getFoodsFromServer() async {
    String url = "$SERVER_IP/api/products/";

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      foods = Products.fromJson(jsonDecode(response.body)).foods;
      return Products.fromJson(jsonDecode(response.body)).foods;
    } else {
      throw Exception("Can't get contents");
    }
  }

  List<dynamic> get items {
    return foods;
  }

  findById(String id) {
    final ty = foods.firstWhere((pdt) => pdt['_id'] == id);

    return ty;
  }
}

class Products with ChangeNotifier {
  List<dynamic> foods = [];

  Products({this.foods});

  factory Products.fromJson(dynamic json) {
    var ty = new Products(foods: json['products']);

    return ty;
  }
}
