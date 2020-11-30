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
  final bool darkThemeEnabled;

  FoodTile(
      {@required this.id,
      @required this.productName,
      @required this.productDesc,
      @required this.productCategory,
      @required this.productImage,
      @required this.productPrice,
      @required this.productQty,
      @required this.darkThemeEnabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodItemScreen(darkThemeEnabled),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    "$SERVER_IP/$productImage",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            productName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Text(
            productDesc,
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

// child: GridTile(
//   child: Image.network(
//     "$SERVER_IP/$productImage",
//     width: 300,
//   ),
//   footer: GridTileBar(
//     title: Text(productName),
//     trailing: IconButton(
//       icon: Icon(Icons.shopping_cart),
//       onPressed: () {
// Scaffold.of(context).showSnackBar(
//   SnackBar(
//     content: Text(
//       'Item added to cart.',
//     ),
//     duration: Duration(seconds: 3),
//   ),
// );
// cart.addItem(pdt.id, pdt.name, pdt.price);
//   },
// ),
// backgroundColor: Colors.black87,
//             );
//           );
//         ),
//       ),
//     );
//   }
// }
