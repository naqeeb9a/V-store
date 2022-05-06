import 'package:flutter/widgets.dart';

class StoreProvider extends ChangeNotifier {
  String store;
  StoreProvider({this.store = ""});
  updateSelectedStore(String value) {
    store = value;
    notifyListeners();
  }
}
