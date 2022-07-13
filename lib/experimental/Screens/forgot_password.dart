import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';

import '../../widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneNumber = TextEditingController();

  bool check = false;
  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Forgot Password",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: Center(
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
                text: "Forgot Your Password?",
                fontSize: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                text:
                    "Please enter your email address or phone number to reset your password",
                fontSize: 12,
                textColor: Color.fromARGB(255, 119, 117, 117),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _phoneNumber,
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.phone_outlined),
                hintText: "Mobile Number",
                prefixIcon: null,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                text: "Reset Password",
                textColor: Colors.white,
                function: () {},
                color: kDarkPurple,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
