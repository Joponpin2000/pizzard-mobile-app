import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/models/response.dart';

class Resp {
  var token;
}

Future<Response> attemptLogin(String email, String password) async {
  final http.Response response = await http.post(
    "$SERVER_IP/api/auth/login",
    body: {
      "email": email,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<int> attemptSignUp(String email, String password) async {
  var res = await http.post(
    "$SERVER_IP/api/auth/signup",
    body: {
      "email": email,
      "password": password,
    },
  );

  return res.statusCode;
}
