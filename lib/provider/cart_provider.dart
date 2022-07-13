import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List cartItems;
  CartProvider({required this.cartItems});
  updateCartItems(value) {
    cartItems.add(value);
    notifyListeners();
  }

  removeItemFromCart(value) {
    cartItems.remove(value);
    notifyListeners();
  }
}
