import 'package:flutter/material.dart';

class SubCategoryProvider extends ChangeNotifier {
  int id;
  SubCategoryProvider({required this.id});
  updateSubCategory(int value) {
    id = value;
    notifyListeners();
  }

  resetSubCategory() {
    id = -1;
  }
}
