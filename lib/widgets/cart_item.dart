import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class CartPdt extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int loadedQuantity;
  final String name;
  final String image;
  final int productQty;

  CartPdt(
      {this.id,
      this.productId,
      this.price,
      this.loadedQuantity,
      this.name,
      this.image,
      @required this.productQty});
  @override
  _CartPdtState createState() => _CartPdtState();
}

class _CartPdtState extends State<CartPdt> {
  String quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.loadedQuantity.toString();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.id);
      },
      child: Card(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image: NetworkImage(
                  "$SERVER_IP/${widget.name}.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            widget.name,
          ),
          subtitle: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              initialValue: widget.loadedQuantity.toString(),
              onChanged: (val) {
                if (val.isNotEmpty) {
                  setState(() => quantity = val);
                  cart.updateSingleItem(widget.id, int.parse(val));
                }
              },
              decoration: InputDecoration(
                filled: true,
              ),
            ),
          ),
          trailing: Text(
            'Total: \$${widget.price * int.parse(quantity)}',
          ),
        ),
      ),
    );
  }
}
