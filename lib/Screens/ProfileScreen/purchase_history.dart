import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/ProfileScreen/purchase_history_detail_page.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Model/user_model.dart';
import '../../provider/user_data_provider.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "My Orders",
          appBar: AppBar(),
          widgets: const [],
          automaticallyImplyLeading: true,
          appBarHeight: 50),
      body: FutureBuilder(
        future: Api().getPurchaseHistory(user!.token.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data["data"].length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    "assets/emptyOrders.json",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(text: "No orders yet!")
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: kDarkPurple)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Order no :"),
                            CustomText(
                                text: snapshot.data["data"][index]["code"]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Payment Type :"),
                            CustomText(
                                text: snapshot.data["data"][index]
                                    ["payment_type"]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Payment Status :"),
                            CustomText(
                                text: snapshot.data["data"][index]
                                    ["payment_status"]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Payable Amount :"),
                            CustomText(
                                text: snapshot.data["data"][index]
                                    ["grand_total"]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Delivery Status"),
                            CustomText(
                                text: snapshot.data["data"][index]
                                    ["delivery_status"]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: "Date :"),
                            CustomText(
                                text: snapshot.data["data"][index]["date"]),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "View details",
                            function: () {
                              KRoutes().push(
                                  context,
                                  PurchaseHistoryDetailPage(
                                      orderId: snapshot.data["data"][index]
                                              ["id"]
                                          .toString()));
                            },
                            color: kDarkPurple)
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
