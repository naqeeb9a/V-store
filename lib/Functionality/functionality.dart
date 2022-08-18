import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/StoreSelectionScreen/selection_screen.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCounter {
  static int incement = 0;
  static updateValue(int value) {
    incement = value;
  }
}

class EssentialFunctions {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }

  Future<void> sendWhatsappMessage(String phoneNumber) async {
    await launchUrl(
        Uri.parse(
          "https://wa.me/923353961635",
        ),
        mode: LaunchMode.externalApplication);
  }

  static Future<bool> checkLoginStatus(
    context,
  ) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String? getUser = user.getString("user");
    if (getUser != null) {
      var jsonData = jsonDecode(getUser);
      Provider.of<UserDataProvider>(context, listen: false).updateUserData(User(
          id: jsonData["user"]["id"],
          type: jsonData["user"]["type"],
          name: jsonData["user"]["name"],
          email: jsonData["user"]["email"],
          avatar: jsonData["user"]["avatar_original"],
          token: jsonData["access_token"]));
      KRoutes().pushAndRemoveUntil(context, const StoreSelection());
      return true;
    }
    return false;
  }

  static loader(context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        lottieAsset: "assets/loader.json",
        barrierDismissible: false);
  }
}
