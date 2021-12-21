import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  int quantity;
  final int price;

  CartItem(
      {required this.id,
        required this.name,
        required this.quantity,
        required this.price});

  int get getQuantity{
    return this.quantity;
  }

  void setQuantity(int i) {
   this.quantity = i;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, String name, int price) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
              (existingCartItem) => CartItem(
              id: pdtid,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pdtid,
              () => CartItem(
            name: name,
            id: pdtid,
            quantity: 1,
            price: price,
          ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

   void increaseQuantity(String id) {
     _items[id]!.setQuantity(_items[id]!.getQuantity + 1);
     notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (_items[id]!.quantity > 1) {
      _items[id]!.setQuantity(_items[id]!.getQuantity - 1);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

}