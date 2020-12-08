import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizzard/screens/FoodItem.dart';
import 'package:pizzard/shared/helper_functions.dart';

class FoodTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodItemScreen(
              loadedId: id,
            ),
          ),
        );
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
                  tag: productImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(
                        "$SERVER_IP/$productImage",
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
                productName,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                productDesc,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
