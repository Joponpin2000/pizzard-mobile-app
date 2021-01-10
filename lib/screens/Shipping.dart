import 'package:flutter/material.dart';
import 'package:pizzard/authenticate/authenticate.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/models/orders.dart';
import 'package:pizzard/screens/PlaceOrder.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  final Cart cart;
  ShippingScreen({@required this.cart});

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  String error = '';
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  placeOrder(cart,orderInstance) async {
    final token = await getJwtToken();
    if (token != null) {
      orderInstance.addOrder(cart.items.values.toList(), cart.totalAmount);
    cart.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceOrder(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Authenticate(
            redirectToOrder: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderInstance = Provider.of<Orders>(context);

    return Scaffold(
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
                        key: _key,
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
                            SizedBox(height: 40),
                            GestureDetector(
                              onTap: () async {
                                if (_key.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  placeOrder(cart,orderInstance);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 10,
                                ),
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Place Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
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
