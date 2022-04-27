import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/AuthenticationScreens/sign_up.dart';
import 'package:store/Screens/tab_bar.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool check = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Login",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textColor: kWhite,
        ),
        backgroundColor: noColor,
        elevation: 0,
      ),
      backgroundColor: kPink,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(20),
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const CustomText(
                            text: "Sign In",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text:
                                "Sign In with your email password to continue",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            controller: _email,
                            label: "Email",
                            hintText: "",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            isPassword: true,
                            controller: _password,
                            label: "Password",
                            hintText: "",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: check,
                                      onChanged: (value) {
                                        setState(() {
                                          check = value!;
                                        });
                                      }),
                                  const CustomText(text: "Remember me")
                                ],
                              ),
                              const CustomText(
                                text: "Forgot password?",
                                textColor: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomButton(
                        text: "Sign In",
                        function: () async {
                          if (_email.text.isEmpty ||
                              !_email.text.contains("@")) {
                            Fluttertoast.showToast(
                                msg: "Enter a Valid email",
                                backgroundColor: Colors.red);
                          } else if (_password.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter a password first",
                                backgroundColor: Colors.red);
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                lottieAsset: "assets/loader.json");
                            var res =
                                await Api().login(_email.text, _password.text);
                            if (res.statusCode == 200) {
                              KRoutes().push(context, const CustomTabBar());
                            } else if (res.statusCode == 401) {
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Invalid credentials",
                                  backgroundColor: Colors.red);
                            } else if (res.statusCode == 500) {
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Server Error",
                                  backgroundColor: Colors.red);
                            } else {
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Check your internet and try again");
                            }
                          }
                        },
                        color: kPink,
                        height: 50,
                        minWidth: double.infinity,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => KRoutes().push(context, const SignUp()),
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: kBlack)),
                          TextSpan(
                              text: "Sign Up", style: TextStyle(color: kPink))
                        ])),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
