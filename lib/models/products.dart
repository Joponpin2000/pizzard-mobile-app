// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:pizzard/shared/helper_functions.dart';
// import 'package:http/http.dart' as http;

// class Product with ChangeNotifier {
//   String id;
//   String productName;
//   String productDesc;
//   String productCategory;
//   String productImage;
//   int productPrice;
//   int productQty;
//   List<Product> _foods = [];
//   Product(
//       {this.id,
//       this.productName,
//       this.productDesc,
//       this.productCategory,
//       this.productImage,
//       this.productPrice,
//       this.productQty});

//   factory Product.fromJson(dynamic json) {
//     print("stud");

//     return new Product(
//       id: json['_id'].toString(),
//       productName: json['productName'],
//       productDesc: json['productDesc'],
//       productCategory: json['productCategory'],
//       productImage: json['productImage'],
//       productPrice: json['productPrice'],
//       productQty: json['productQty'],
//     );
//   }

//   // Future<void> getFoodsFromServer() async {
//   //   String url = "$SERVER_IP/api/products/";

//   //   final http.Response response = await http.get(url);

//   //   if (response.statusCode == 200) {
//   //     final json = jsonDecode(response.body);

//   //     if (json != null) {
//   //       _foods = json.map((String ok, dynamic item) {
//   //         String id = item['_id'];
//   //         String productName = item['productName'];
//   //         String productDesc = item['productDesc'];
//   //         String productCategory = item['productCategory'];
//   //         String productImage = item['productImage'];
//   //         int productPrice = item['productPrice'];
//   //         int productQty = item['productQty'];

//   //         return new Product(
//   //           id: id,
//   //           productCategory: productCategory,
//   //           productDesc: productDesc,
//   //           productImage: productImage,
//   //           productName: productName,
//   //           productPrice: productPrice,
//   //           productQty: productQty,
//   //         );
//   //       }).toList();
//   // json.forEach((i, element) {
//   //    _foods = Product.fromJson(element);
//   //   print("stud");
//   // });
//   //   }
//   // } else {
//   //   throw Exception("Can't get contents");
//   // }
//   // }
// }

// class ProductsList with ChangeNotifier {
//   final List<dynamic> products;

//   ProductsList({
//     this.products,
//   });

//   factory ProductsList.fromJson(List<dynamic> json) {
//     List<Product> products = new List<Product>();

//     products = json.map((i) => Product.fromJson(i)).toList();

//     return new ProductsList(products: products);
//   }

//   Future<dynamic> getFoodsFromServer() async {
//     String url = "$SERVER_IP/api/products/";

//     final http.Response response = await http.get(url);

//     if (response.statusCode == 200) {
//       final pJson = jsonDecode(response.body);
//       ProductsList.fromJson(pJson);
//     }
//   }
// }

// class Products with ChangeNotifier {
//   List<Product> foods = [];

//   Products({foods});

//   List<Product> get items {
//     getFoodsFromServer();
//     // print([...foods]);
//     return [...foods];
//   }

//   Product findById(String id) {
//     return foods.firstWhere((pdt) => pdt.id == id);
//   }

//   factory Products.fromJson(Products json) {
//     Products(foods: json);
//     print(Products().foods);
//     return Products();
//   }

//   Future<List<Product>> getFoodsFromServer() async {
//     String url = "$SERVER_IP/api/products/";

//     final http.Response response = await http.get(url);

//     if (response.statusCode == 200) {
//       return foods =
//           Products.fromJson(jsonDecode(response.body)['products']).foods;
//     } else {
//       throw Exception("Can't get contents");
//     }
//   }
// }
