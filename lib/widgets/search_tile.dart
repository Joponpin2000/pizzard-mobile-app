import 'package:flutter/material.dart';
import 'package:pizzard/screens/FoodItem.dart';
import 'package:pizzard/shared/helper_functions.dart';

class SearchTile extends StatelessWidget {
  final String productId;
  final int productPrice;
  final String productName;
  final String productImage;

  const SearchTile(
      {Key key,
      this.productId,
      this.productPrice,
      this.productName,
      this.productImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodItemScreen(
                loadedId: productId,
              ),
            ),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
              image: NetworkImage(
                "$SERVER_IP/$productImage",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          productName,
        ),
        trailing: Text(
          '\$$productPrice',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}