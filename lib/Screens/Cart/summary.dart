import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../Model/user_model.dart';
import '../../provider/user_data_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "Cart Summary",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: FutureBuilder(
        future: Api().getCartSummary(user!.token.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Sub Total"),
                    CustomText(
                      text: snapshot.data["sub_total"].toString(),
                      textColor: kBlack,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Delivery"),
                    CustomText(
                      text: snapshot.data["shipping_cost"].toString(),
                      textColor: kBlack.withOpacity(0.3),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Discount"),
                    CustomText(
                      text: snapshot.data["discount"].toString(),
                      textColor: kBlack.withOpacity(0.3),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Grand Total"),
                    Row(
                      children: [
                        CustomText(
                          text: "Rs. ",
                          textColor: kBlack.withOpacity(0.3),
                        ),
                        CustomText(
                          text: snapshot.data["grand_total_value"].toString(),
                          textColor: kDarkPurple,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Copoun"),
                    CustomText(
                      text: snapshot.data["coupon_applied"] == false
                          ? "✖️ No Copoun Applied"
                          : "✔️ Copoun Applied",
                      textColor: snapshot.data["coupon_applied"] == false
                          ? Colors.red
                          : kDarkPurple,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomTextField(
                    prefixIcon: Icon(CupertinoIcons.gift),
                    controller: null,
                    hintText: "Ex: Welcome20"),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
