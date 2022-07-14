import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/Model/user_model.dart';

import 'package:store/Screens/AuthenticationScreens/sign_up.dart';
import 'package:store/Screens/StoreSelectionScreen/selection_screen.dart';
import 'package:store/experimental/Screens/forgot_password.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';

import '../../utils/app_routes.dart';
import '../../widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool check = true;
  @override
  void initState() {
    checkStatus();

    super.initState();
  }

  checkStatus() async {
    await EssentialFunctions.checkLoginStatus(context)
        .then((value) => Future.delayed(
                const Duration(
                  seconds: 1,
                ), () {
              if (value == false) {
                setState(() {
                  check = false;
                });
              }
            }));
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return check == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: BaseAppBar(
                title: "Login",
                appBar: AppBar(),
                automaticallyImplyLeading: true,
                widgets: const [],
                appBarHeight: 50),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo.jpeg",
                        width: 200,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const CustomText(
                        text: "Welcome",
                        fontSize: 20,
                      ),
                      const CustomText(
                        text: "Check out our fresh veggies from our store",
                        fontSize: 12,
                        textColor: Color.fromARGB(255, 119, 117, 117),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.email_outlined),
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _password,
                        suffixIcon: const Icon(
                          Icons.visibility_outlined,
                        ),
                        hintText: "Password",
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () =>
                            KRoutes().push(context, const ForgotPassword()),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            text: "Forgot password?",
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Login",
                        textColor: Colors.white,
                        function: () async {
                          if (_email.text.isEmpty ||
                              !_email.text.contains("@") ||
                              !_email.text.contains(".")) {
                            Fluttertoast.showToast(msg: "Enter a Valid Email");
                          } else if (_password.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Password can't be empty");
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                barrierDismissible: false);
                            Response res =
                                await Api().login(_email.text, _password.text);
                            if (res.statusCode == 200) {
                              var jsonData = jsonDecode(res.body);
                              Provider.of<UserDataProvider>(context,
                                      listen: false)
                                  .updateUserData(User(
                                      id: jsonData["user"]["id"],
                                      type: jsonData["user"]["type"],
                                      name: jsonData["user"]["name"],
                                      email: jsonData["user"]["email"],
                                      avatar: jsonData["user"]
                                          ["avatar_original"],
                                      token: jsonData["access_token"]));
                              SharedPreferences user =
                                  await SharedPreferences.getInstance();
                              user.setString("user", res.body);
                              KRoutes().pop(context);
                              KRoutes().pushAndRemoveUntil(
                                  context, const StoreSelection());
                            } else {
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Email or password incorrect");
                            }
                          }
                        },
                        color: kDarkPurple,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => KRoutes().push(context, const SignUp()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              text: "Don't have an account? ",
                            ),
                            CustomText(
                              text: "Create Account",
                              textColor: kDarkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
