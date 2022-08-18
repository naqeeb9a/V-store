import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/Screens/ProfileScreen/purchase_history.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/custom_text.dart';

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
            const SizedBox(
              height: 10,
            ),
            const CustomText(text: "Thank you for your time"),
            const SizedBox(
              height: 10,
            ),
            const CustomText(text: "Your order has been confirmed"),
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
            CustomButton(
              text: "Go to my orders ->",
              function: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                KRoutes().push(context, const PurchaseHistory());
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
