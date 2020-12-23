import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String image;
  final int productQty;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.quantity,
      @required this.price,
      @required this.image,
      @required this.productQty});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
      String pdtId, String name, double price, String image, int productQty) {
    if (_items.containsKey(pdtId)) {
      _items.update(
          pdtId,
          (existingCartItem) => CartItem(
                id: DateTime.now().toString(),
                name: existingCartItem.name,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
                image: existingCartItem.image,
                productQty: existingCartItem.productQty,
              ));
    } else {
      _items.putIfAbsent(
          pdtId,
          () => CartItem(
              name: name,
              id: DateTime.now().toString(),
              quantity: 1,
              price: price,
              image: image,
              productQty: productQty));
    }

    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
                id: DateTime.now().toString(),
                name: existingCartItem.name,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
                image: existingCartItem.image,
                productQty: existingCartItem.productQty,
              ));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price + cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  List<int> convertQtyToList() {
    var listItems = [];
    _items.forEach((key, cartItem) {
      List<int> numbers = [];
      for (int i = 1; i <= cartItem.productQty; i++) {
        numbers.add(i);
      }
      return listItems.add(IterableList(id: cartItem.id, list: numbers));
    });
    return listItems;
  }
}

class IterableList {
  final String id;
  final List list;

  IterableList({this.id, this.list});
}
