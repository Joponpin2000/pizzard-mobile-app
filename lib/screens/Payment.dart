import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/services/payment.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _horizontalSizeBox = const SizedBox(width: 10.0);
  CheckoutMethod _method;
  bool _inProgress = false;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  int amount;
  String email;
  String name;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: PUBLIC_KEY);
    initializeStateValues();
    super.initState();
  }

  initializeStateValues() async {
    email = await HelperFunctions.getUserEmailSharedPreference();
    name = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    setState(() {
      amount = cart.totalAmount.toInt();
    });
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: const Text(appName)),
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            child: Theme(
              data: Theme.of(context).copyWith(
                accentColor: green,
                primaryColorLight: Colors.white,
                primaryColorDark: navyBlue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      bodyText2: TextStyle(
                        color: lightBlue,
                      ),
                    ),
              ),
              child: Builder(
                builder: (context) {
                  return _inProgress
                      ? new Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Platform.isIOS
                              ? new CupertinoActivityIndicator()
                              : new CircularProgressIndicator(),
                        )
                      : new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // _getPlatformButton(
                            //     'Charge Card', () => _startAfreshCharge()),
                            // _verticalSizeBox,
                            // _border,
                            new SizedBox(
                              height: 40.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Flexible(
                                  flex: 3,
                                  child: new DropdownButtonHideUnderline(
                                    child: new InputDecorator(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                        hintText: 'Checkout method',
                                      ),
                                      isEmpty: _method == null,
                                      child: new DropdownButton<CheckoutMethod>(
                                        value: _method,
                                        isDense: true,
                                        onChanged: (CheckoutMethod value) {
                                          setState(() {
                                            _method = value;
                                          });
                                        },
                                        items: banks.map((String value) {
                                          return new DropdownMenuItem<
                                              CheckoutMethod>(
                                            value: _parseStringToMethod(value),
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                _horizontalSizeBox,
                                new Flexible(
                                  flex: 2,
                                  child: new Container(
                                    width: double.infinity,
                                    child: _getPlatformButton(
                                      'Checkout',
                                      () => _handleCheckout(context),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOnServer(String reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$SERVER_IP/api/paystack/callback?ref=$reference';
    try {
      http.Response response = await http.get(url);
      _updateStatus(reference,
          PaymentResponse.fromJson(jsonDecode(response.body)).successMessage);
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying the payment: '
          '$reference $e');
    }
    setState(() => _inProgress = false);
  }

  _handleCheckout(BuildContext context) async {
    if (_method == null) {
      _showMessage('Select checkout method first');
      return;
    }

    setState(() => _inProgress = true);
    _formKey.currentState.save();
    Charge charge = Charge()
      ..amount = (amount * 100) // In base currency
      ..email = email
      ..reference = _getReference()
      ..card = _getCardFromUI();
    charge.reference = _getReference();

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      _verifyOnServer(response.reference);
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );

    // Using Cascade notation (similar to Java's builder pattern)
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear)
//      ..name = 'Segun Chukwuma Adamu'
//      ..country = 'Nigeria'
//      ..addressLine1 = 'Ikeja, Lagos'
//      ..addressPostalCode = '100001';

    // Using optional parameters
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear,
//        name: 'Ismail Adebola Emeka',
//        addressCountry: 'Nigeria',
//        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new RaisedButton(
        onPressed: function,
        color: Colors.blueAccent,
        textColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  _updateStatus(String reference, String message) {
    _showMessage('Response: $message\nReference: $reference ',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

}

var banks = ['Selectable', 'Bank', 'Card'];

CheckoutMethod _parseStringToMethod(String string) {
  CheckoutMethod method = CheckoutMethod.selectable;
  switch (string) {
    case 'Bank':
      method = CheckoutMethod.bank;
      break;
    case 'Card':
      method = CheckoutMethod.card;
      break;
  }
  return method;
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Image(
        image: AssetImage("assets/icon.png"),
        height: 50,
      ),
    );
  }
}

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);
