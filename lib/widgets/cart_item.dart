import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class CartPdt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String name;
  final String image;

  CartPdt(
      {this.id,
      this.productId,
      this.price,
      this.quantity,
      this.name,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
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
                  "$SERVER_IP/$image",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            name,
          ),
          subtitle: Text(
            'Total: \$${price * quantity}',
          ),
          trailing: Text(
            '$quantity x',
          ),
        ),
      ),
    );
  }
}
