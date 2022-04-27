import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List? cartItems;
  CartProvider({this.cartItems});
  updateCartItems(value) {
    cartItems!.add(value);
    ChangeNotifier();
  }

  removeItemFromCart(int index) {
    cartItems!.removeAt(index);
    ChangeNotifier();
  }
}
