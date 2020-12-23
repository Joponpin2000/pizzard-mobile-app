import 'package:flutter/material.dart';
import 'package:pizzard/services/foods.dart';
import 'package:pizzard/widgets/search_tile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  List<dynamic> foods;
  bool _loading = false;

  getFoods(items) {
    if (this.mounted) {
      if (items != null && items != []) {
        setState(() {
          _loading = false;
          foods = items;
        });
      }
    }
  }

  Widget searchList() {
    return foods != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return SearchTile(
                productId: foods[index]['_id'],
                productName: foods[index]['productName'],
                productImage: foods[index]['productImage'],
                productPrice: foods[index]['productPrice'],
              );
            },
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Foods>(context);
    productData.searchFoodFromServer(query).then((items) {
      getFoods(items);
    });

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey[100],
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _loading = true;
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search..',
                    border: InputBorder.none,
                  ),
                ),
              ),
              _loading
                  ? Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(child: searchList()),
            ],
          ),
        ),
      ),
    );
  }
}
