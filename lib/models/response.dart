import 'package:pizzard/models/food.dart';

class Response {
  String token;

  Response({this.token});

  factory Response.fromJson(dynamic json) {
    return Response(token: json['token']);
  }
}

class Products {
  List<dynamic> foods = [];

  Products({this.foods});

  factory Products.fromJson(dynamic json) {
    return Products(foods: json['products']);
  }
}
