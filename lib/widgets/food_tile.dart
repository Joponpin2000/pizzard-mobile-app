import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizzard/models/cart.dart';
import 'package:pizzard/shared/helper_functions.dart';
import 'package:provider/provider.dart';

class FoodTile extends StatefulWidget {
  final id,
      productName,
      productDesc,
      productCategory,
      productImage,
      productPrice,
      productQty;

  FoodTile({
    @required this.id,
    @required this.productName,
    @required this.productDesc,
    @required this.productCategory,
    @required this.productImage,
    @required this.productPrice,
    @required this.productQty,
  });

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    void _showPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Hero(
                      tag: widget.productImage,
                      child: Image(
                        image: NetworkImage(
                          "$SERVER_IP/${widget.productName}.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        '${widget.productName}',
                      ),
                      subtitle: Text(
                        '${widget.productDesc}',
                      ),
                      trailing: Text('\$${widget.productPrice}'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cart.addItem(
                        widget.id,
                        widget.productName,
                        widget.productPrice.toDouble(),
                        widget.productImage,
                        widget.productQty,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }

    return GestureDetector(
      onTap: () {
        _showPanel();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey[100],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: widget.productImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(
                        "$SERVER_IP/${widget.productName}.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.productName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productDesc,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '\$${widget.productPrice.toString()}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
