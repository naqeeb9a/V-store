import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:store/Api/api.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../utils/app_routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Sign Up",
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
                  height: 50,
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
                  controller: _name,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.person_outline),
                  hintText: "Full Name",
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
                  isPassword: true,
                  suffixIcon: const Icon(Icons.visibility_outlined),
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _cPassword,
                  isPassword: true,
                  suffixIcon: const Icon(
                    Icons.visibility_outlined,
                  ),
                  hintText: "Confirm Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Sign Up",
                  textColor: Colors.white,
                  function: () async {
                    if (_cPassword.text != _password.text) {
                      Fluttertoast.showToast(msg: "Password don't match");
                    } else if (_email.text.isEmpty || _name.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Fill all fields");
                    } else if (!_email.text.contains("@") &&
                        !_email.text.contains(".")) {
                      Fluttertoast.showToast(msg: "Enter a Valid Email");
                    } else {
                      Response res = await Api()
                          .signUp(_email.text, _name.text, _password.text);
                          if(res.statusCode==200)
                          {
                            
                          }
                    }
                  },
                  color: kDarkPurple,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => KRoutes().pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account? ",
                      ),
                      CustomText(
                        text: "Login",
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
