import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/custom_text.dart';

import '../../utils/colors.dart';

class PurchaseHistoryDetailPage extends StatelessWidget {
  final String orderId;
  const PurchaseHistoryDetailPage({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "Detail page",
          appBar: AppBar(),
          widgets: const [],
          automaticallyImplyLeading: true,
          appBarHeight: 50),
      body: Column(
        children: [
          FutureBuilder(
            future:
                Api().purchaseHistoryDetails(user!.token.toString(), orderId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Shipping Address :"),
                          CustomText(
                              text: snapshot.data["data"][0]["shipping_address"]
                                  ["address"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Payment Type :"),
                          CustomText(
                              text: snapshot.data["data"][0]["payment_type"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Payment Status :"),
                          CustomText(
                              text: snapshot.data["data"][0]["payment_status"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Coupon discount :"),
                          CustomText(
                              text: snapshot.data["data"][0]
                                  ["coupon_discount"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Payable Amount :"),
                          CustomText(
                              text: snapshot.data["data"][0]["subtotal"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Delivery Status"),
                          CustomText(
                              text: snapshot.data["data"][0]
                                  ["delivery_status"]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Date :"),
                          CustomText(text: snapshot.data["data"][0]["date"]),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
            },
          ),
          const Divider(
            thickness: 1,
          ),
          const CustomText(text: "All items "),
          Expanded(
            child: FutureBuilder(
              future: Api().purchaseHistory(user.token.toString(), orderId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: Column(
                        children: (snapshot.data["data"] as List)
                            .map((e) => Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 1, color: kDarkPurple)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: CustomText(
                                          text: e["product_name"],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(text: "Variation:"),
                                          CustomText(text: e["variation"])
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(text: "Price :"),
                                          CustomText(
                                              text: e["price"].toString())
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(text: "Quantity :"),
                                          CustomText(
                                              text: e["quantity"].toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                            .toList()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
