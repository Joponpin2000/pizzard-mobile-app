import 'package:flutter/material.dart';
import 'package:pizzard/widgets/food_tile.dart';

class FoodList extends StatelessWidget {
  final List<dynamic> foods;
  final bool darkThemeEnabled;

  FoodList({this.foods, this.darkThemeEnabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: foods.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: FoodTile(darkThemeEnabled: darkThemeEnabled,
          
            id: foods[index]['_id'],
            productCategory: foods[index]['productCategory'],
            productName: foods[index]['productName'],
            productDesc: foods[index]['productDesc'],
            productImage: foods[index]['productImage'],
            productPrice: foods[index]['productPrice'],
            productQty: foods[index]['productQty'],
          ),
        );
      },
      // children: <Widget>[
      //   SizedBox(height: 10),
      //   Center(
      //     child: Text(
      //       'Products',
      //       style: TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      //   GridView.builder(
      //     physics: ScrollPhysics(),
      //     shrinkWrap: true,
      //     itemCount: foods.length,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 8),
      //     itemBuilder: (context, index) {
      //       return FoodTile(
      //         id: foods[index]['_id'],
      //         productCategory: foods[index]['productCategory'],
      //         productName: foods[index]['productName'],
      //         productDesc: foods[index]['productDesc'],
      //         productImage: foods[index]['productImage'],
      //         productPrice: foods[index]['productPrice'],
      //         productQty: foods[index]['productQty'],
      //       );
      //     },
      //   )
      // ],
    );
    // return Container(
    //   padding: EdgeInsets.only(
    //     top: 16,
    //     left: 20,
    //     right: 20,
    //   ),
    //   margin: EdgeInsets.only(bottom: 20),
    //   child: ListView.builder(
    //     itemCount: foods.length,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       return FoodTile(
    //         id: foods[index]['_id'],
    //         productCategory: foods[index]['productCategory'],
    //         productName: foods[index]['productName'],
    //         productDesc: foods[index]['productDesc'],
    //         productImage: foods[index]['productImage'],
    //         productPrice: foods[index]['productPrice'],
    //         productQty: foods[index]['productQty'],
    //       );
    //     },
    //   ),
    // );
  }
}
