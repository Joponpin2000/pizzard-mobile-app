import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizzard/models/response.dart';

import 'package:pizzard/shared/helper_functions.dart';

class Foods {
  List<dynamic> foods = [];

  Future<dynamic> getFoodsFromServer() async {
    String url = "$SERVER_IP/api/products/";

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      foods = Products.fromJson(jsonDecode(response.body)).foods;
    } else {
      throw Exception("Can't get contents");
    }
  }
}
