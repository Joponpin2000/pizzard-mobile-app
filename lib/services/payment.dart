
import 'package:flutter/cupertino.dart';

class PaymentResponse with ChangeNotifier {
  String successMessage = '';

  PaymentResponse({this.successMessage});

  factory PaymentResponse.fromJson(dynamic json) {
    var ty = new PaymentResponse(successMessage: json['successMessage']);

    return ty;
  }
}
