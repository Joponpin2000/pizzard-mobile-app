import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// const SERVER_IP = 'http://pizzard.herokuapp.com';
const SERVER_IP = 'http://192.168.43.201:4000';
const PUBLIC_KEY = 'pk_test_b5c70113d9924c7dc4fd61a362c51fe24c5c3181';

const String appName = 'Pizzards';

getJwtToken() async {
  return await HelperFunctions.getJwtSharedPreference();
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('Invalid payload');
  }
  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!');
  }

  return utf8.decode(base64Url.decode(output));
}

bool validateJwt(payload) {
  if (DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000)
      .isAfter(DateTime.now())) {
    return true;
  } else {
    return false;
  }
}

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceJwtKey = "jwt";
  static String sharedPreferenceDarkThemeKey = "DARKTHEME";

  static Future<bool> saveJwtSharedPreference(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceJwtKey, jwt);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> saveDarkThemeSharedPreference(bool jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceDarkThemeKey, jwt);
  }

  static Future<String> getJwtSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(sharedPreferenceJwtKey);
    return value;
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<bool> getDarkThemeSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(sharedPreferenceDarkThemeKey);
    return value;
  }

  static deleteLoginSharedPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var rs = prefs.remove(key);
    print('okay');
    print(rs);
  }

  static signOut() async {
    await deleteLoginSharedPreference(sharedPreferenceUserLoggedInKey);
    await deleteLoginSharedPreference(sharedPreferenceJwtKey);
    await deleteLoginSharedPreference(sharedPreferenceUserNameKey);
    await deleteLoginSharedPreference(sharedPreferenceUserEmailKey);
  }
}
