import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Authentication",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 70),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/logo.jpeg",
                width: 200,
              ),
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  text:
                      "We have sent a code to your e-mail, Please enter and continue",
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.scale,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                cursorColor: kBlack,
                autoDisposeControllers: true,
                useHapticFeedback: true,
                controller: textEditingController,
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
                pinTheme: PinTheme(
                    disabledColor: kDarkPurple,
                    activeColor: kDarkPurple,
                    inactiveColor: kDarkPurple,
                    selectedColor: kDarkPurple),
                appContext: context,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: "SUBMIT",
                textColor: Colors.white,
                function: () {},
                color: kDarkPurple,
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
