import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Api/api.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Registration",
          appBar: AppBar(),
          widgets: const [],
          automaticallyImplyLeading: false,
          appBarHeight: 70),
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
                            text: "Sign Up",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text:
                                "Sign Up with your email password to continue",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            controller: _name,
                            label: "Name",
                            hintText: "",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _email,
                            label: "Email Address",
                            hintText: "",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _password,
                            isPassword: true,
                            label: "Password",
                            hintText: "",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomButton(
                        text: "Sign Up",
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
                          } else if (_name.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Enter a name first");
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                lottieAsset: "assets/loader.json");
                            var res = await Api().signUp(
                                _name.text, _email.text, _password.text);
                            if (res.statusCode == 200) {
                              KRoutes().pop(context);
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Signed Up sccuessfully please login",
                                  backgroundColor: Colors.red);
                            } else if (res.statusCode == 201) {
                              KRoutes().pop(context);
                              Fluttertoast.showToast(
                                  msg: "Already Registered",
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
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: kBlack)),
                        TextSpan(
                            text: "Sign In", style: TextStyle(color: kPink))
                      ]))
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
