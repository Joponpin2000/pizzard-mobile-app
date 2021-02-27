import 'package:flutter/material.dart';
import 'package:pizzard/shared/helper_functions.dart';

class OrderPdt extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int loadedQuantity;
  final String name;
  final String image;
  final int productQty;
  final bool cartPage;
  final DateTime dateTime;

  OrderPdt({
    this.id,
    this.productId,
    this.price,
    this.loadedQuantity,
    this.name,
    this.image,
    @required this.productQty,
    this.cartPage, this.dateTime,
  });
  @override
  _OrderPdtState createState() => _OrderPdtState();
}

class _OrderPdtState extends State<OrderPdt> {
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

  @override
  Widget build(BuildContext context) {
    return Card(
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
        subtitle: Text("${widget.dateTime}"),
        trailing: Column(
          children: [
            Text("$quantity x"),
            Text(
              'Total: \$${widget.price * quantity}',
            ),
          ],
        ),
      ),
    );
  }
}
