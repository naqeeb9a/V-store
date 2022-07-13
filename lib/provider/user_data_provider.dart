import 'package:flutter/foundation.dart';
import 'package:store/Model/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  User? user;
  UserDataProvider({this.user});
  updateUserData(User data) {
    user = data;
    notifyListeners();
  }
}
