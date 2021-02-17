import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/models/orders.dart';
import 'package:pizzard/screens/Orders.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pizzard/services/payment.dart';

class ShippingScreen extends StatefulWidget {
  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Cart instanceOfCart;
  Orders instanceOfOrder;
  CheckoutMethod _method;
  bool _inProgress = false;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  int amount;
  String email;
  String name;
  bool isLoading = false;
  String error = '';
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

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

  Widget _getPlatformButton(String string, Function() function) {
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
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  _handleCheckout(BuildContext context) async {
    if (_formKey.currentState.validate()) {
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
  }

  void _verifyOnServer(String reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$SERVER_IP/api/paystack/callback?ref=$reference';
    try {
      http.Response response = await http.get(url);
      _updateStatus(reference,
          PaymentResponse.fromJson(jsonDecode(response.body)).successMessage);

      instanceOfOrder.addOrder(
          instanceOfCart.items.values.toList(), instanceOfCart.totalAmount);
      instanceOfCart.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrdersScreen(),
        ),
      );
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying the payment: '
          '$reference $e');
    }
    setState(() => _inProgress = false);
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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderInstance = Provider.of<Orders>(context);
    setState(() {
      amount = cart.totalAmount.toInt();
      instanceOfOrder = orderInstance;
      instanceOfCart = cart;
    });

    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              top: true,
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  padding: EdgeInsets.all(25),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Shipping',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Address',
                                icon: Icon(Icons.location_on),
                              ),
                              controller: addressController,
                              validator: (value) => value.isEmpty
                                  ? "Address Shouldn't be empty"
                                  : null,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'City',
                                icon: Icon(Icons.location_city_rounded),
                              ),
                              controller: cityController,
                              validator: (value) => value.isEmpty
                                  ? "City Shouldn't be empty"
                                  : null,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Country',
                                icon: Icon(Icons.not_listed_location_outlined),
                              ),
                              controller: countryController,
                              validator: (value) => value.isEmpty
                                  ? "Country Shouldn't be empty"
                                  : null,
                            ),
                            SizedBox(height: 20),
                            _inProgress
                                ? new Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    child: Platform.isIOS
                                        ? new CupertinoActivityIndicator()
                                        : new CircularProgressIndicator(),
                                  )
                                : new Column(
                                    children: <Widget>[
                                      new DropdownButtonHideUnderline(
                                        child: new InputDecorator(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                            hintText: 'Checkout method',
                                          ),
                                          isEmpty: _method == null,
                                          child: new DropdownButton<
                                              CheckoutMethod>(
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
                                                value:
                                                    _parseStringToMethod(value),
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      new Container(
                                        width: double.infinity,
                                        child: _getPlatformButton(
                                          'Checkout',
                                          () => _handleCheckout(context),
                                        ),
                                      ),
                                    ],
                                  ),
                            // GestureDetector(
                            //   onTap: () async {
                            //     if (_formKey.currentState.validate()) {
                            //       setState(() {
                            //         isLoading = true;
                            //       });
                            //       placeOrder(cart, orderInstance);
                            //     }
                            //   },
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: EdgeInsets.symmetric(
                            //       vertical: 15,
                            //       horizontal: 10,
                            //     ),
                            //     color: Theme.of(context).primaryColor,
                            //     child: Text(
                            //       'Checkout',
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
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
