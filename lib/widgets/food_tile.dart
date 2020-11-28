import 'package:flutter/material.dart';
import 'package:pizzard/shared/helper_functions.dart';

class FoodTile extends StatelessWidget {
  var _id,
      productName,
      productDesc,
      productCategory,
      productImage,
      productPrice,
      productQty;

  FoodTile(
    _id,
    productName,
    productDesc,
    productCategory,
    productImage,
    productPrice,
    productQty,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     // builder: (context) => ArticleView(blogUrl: url),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network("$SERVER_IP/$productImage"),
            ),
            Text(
              productName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              productDesc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
