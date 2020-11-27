import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizzard/models/response.dart';

import 'package:pizzard/shared/helper_functions.dart';

class Foods {
  Future<void> getFoodsFromServer() async {
    String url = "$SERVER_IP/api/products/";

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return Products.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Can't get contents");
    }

    // var jsonData = jsonDecode(response.body);
    // if (jsonData['status'] == 'ok') {
    //   jsonData['articles'].forEach((element) {
    //     if (element["urlToImage"] != null && element["description"] != null) {
    //       ArticleModel articleModel = new ArticleModel(
    //         title: element['title'],
    //         author: element['author'],
    //         description: element['description'],
    //         url: element['url'],
    //         urlToImage: element['urlToImage'],
    //         content: element['content'],
    //       );

    //       news.add(articleModel);
    //     }
    //   });
    // }
  }
}
