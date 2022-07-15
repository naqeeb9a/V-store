import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/widgets/custom_app_bar.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Order Confirmed",
          appBar: AppBar(),
          widgets: const [],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Spacer(),
            LottieBuilder.asset(
              "assets/order.json",
              width: MediaQuery.of(context).size.width * 0.7,
              repeat: false,
            ),
            const Spacer(),
            CustomButton(
              text: "Shop More",
              function: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              color: kDarkPurple,
              minWidth: double.infinity,
              textColor: kWhite,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
