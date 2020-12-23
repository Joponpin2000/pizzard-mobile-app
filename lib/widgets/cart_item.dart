import 'package:flutter/material.dart';
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
  int quantity;
  List<int> iterable = [];
  @override
  void initState() {
    super.initState();
    quantity = widget.loadedQuantity;
    iterable = convertQtyToList(widget.productQty);
  }

  List<int> convertQtyToList(number) {
    List<int> numbers = [];
    for (int i = 1; i <= number; i++) {
      numbers.add(i);
    }
    return numbers;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(widget.id);

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
                  "$SERVER_IP/${widget.image}",
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
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              value: widget.loadedQuantity,
              items: iterable.map((qt) {
                return DropdownMenuItem(
                  value: qt,
                  child: Text('$qt'),
                );
              }).toList(),
              onChanged: (val) => setState(() => quantity = val),
            ),
          ),
          trailing: Text(
            'Total: \$${widget.price * quantity}',
          ),
        ),
      ),
    );
  }
}
