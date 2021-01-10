import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizzard/shared/helper_functions.dart';
import 'package:pizzard/models/response.dart';

class Resp {
  var token;
}

Future attemptLogin(String email, String password) async {
  var res = [
    {"token": ""},
    {"errorMessage": ""},
  ];
  final http.Response response = await http.post(
    "$SERVER_IP/api/auth/login",
    body: {
      "email": email,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    res[0]["token"] = "${Response.fromJson(jsonDecode(response.body)).token}";
    var email = "${Response.fromJson(jsonDecode(response.body)).user.email}";
    var username =
        "${Response.fromJson(jsonDecode(response.body)).user.username}";
    await HelperFunctions.saveUserEmailSharedPreference(email);
    await HelperFunctions.saveUserNameSharedPreference(username);
    return res;
  } else {
    if (jsonDecode(response.body)["errorMessage"] != null) {
      res[0]["errorMessage"] =
          jsonDecode(response.body)["errorMessage"].toString();
    } else {
      res[0]["errorMessage"] = "Error connecting. Try again.";
    }
      return res;
  }
}

Future attemptSignUp(String username, String email, String password) async {
  var res = [
    {"successMessage": ""},
    {"errorMessage": ""},
  ];

  final http.Response response = await http.post(
    "$SERVER_IP/api/auth/signup",
    body: {
      "email": email,
      "username": username,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    res[0]["successMessage"] =
        jsonDecode(response.body)["successMessage"].toString();
    return res;
  } else {
    if (jsonDecode(response.body)["errorMessage"] != null) {
      res[0]["errorMessage"] =
          jsonDecode(response.body)["errorMessage"].toString();
    } else {
      res[0]["errorMessage"] = "Error connecting. Try again.";
    }
    return res;
  }
}
