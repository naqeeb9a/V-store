import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/Cart/order_confirmation_screen.dart';
import 'package:store/Screens/ProfileScreen/addresses_screen.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../Functionality/functionality.dart';
import '../../Model/user_model.dart';
import '../../provider/user_data_provider.dart';
import '../../utils/app_routes.dart';
import '../../widgets/custom_button.dart';

class SummaryScreen extends StatefulWidget {
  final String ownerId;
  const SummaryScreen({Key? key, required this.ownerId}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final TextEditingController _copounCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    bool loading = false;
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Sub Total",
                        fontSize: 20,
                      ),
                      CustomText(
                        text: snapshot.data["sub_total"].toString(),
                        textColor: kBlack,
                        fontSize: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Delivery",
                        fontSize: 20,
                      ),
                      CustomText(
                        text: snapshot.data["shipping_cost"].toString(),
                        textColor: kBlack.withOpacity(0.3),
                        fontSize: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Discount",
                        fontSize: 20,
                      ),
                      CustomText(
                        text: snapshot.data["discount"].toString(),
                        textColor: kBlack.withOpacity(0.3),
                        fontSize: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Grand Total",
                        fontSize: 20,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Rs. ",
                            textColor: kBlack.withOpacity(0.3),
                            fontSize: 20,
                          ),
                          CustomText(
                            text: snapshot.data["grand_total_value"].toString(),
                            textColor: kDarkPurple,
                            fontSize: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
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
                  StatefulBuilder(builder: (context, changeState) {
                    return CustomTextField(
                        prefixIcon: const Icon(CupertinoIcons.gift),
                        suffixIcon: InkWell(
                          onTap: () async {
                            User? user = context.read<UserDataProvider>().user;
                            if (_copounCode.text.isEmpty &&
                                snapshot.data["coupon_applied"] == false) {
                              Fluttertoast.showToast(
                                  msg: "please fill the field first");
                            } else {
                              changeState(() {
                                loading = true;
                              });
                              dynamic res = "";
                              if (snapshot.data["coupon_applied"] == false) {
                                res = await Api().applyCopoun(
                                    user!.id.toString(),
                                    widget.ownerId,
                                    _copounCode.text,
                                    user.token.toString());
                              } else {
                                res = await Api().removeCopoun(
                                    user!.id.toString(),
                                    widget.ownerId,
                                    user.token.toString());
                              }
                              if (res != false) {
                                setState(() {});
                                _copounCode.clear();
                                Fluttertoast.showToast(msg: "Coupon applied");
                              } else {
                                changeState(() {
                                  loading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Failed to apply coupon");
                              }
                            }
                          },
                          child: loading == true
                              ? const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child:
                                          CircularProgressIndicator.adaptive()),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data["coupon_applied"] == false
                                          ? Text(
                                              "Apply",
                                              style:
                                                  TextStyle(color: kDarkPurple),
                                            )
                                          : const Text(
                                              "Remove",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                    ],
                                  ),
                                ),
                        ),
                        controller: _copounCode,
                        hintText: "Ex: Welcome20");
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: "Select Address",
                    function: () {
                      KRoutes().push(
                          context,
                          const AddressesScreen(
                            showConfirmButton: true,
                          ));
                    },
                    color: kDarkPurple,
                    minWidth: double.infinity,
                    textColor: kWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: "Confirm Order",
                    function: () async {
                      EssentialFunctions.loader(context);
                      var res = await Api().createOrder(user.id.toString(),
                          widget.ownerId, user.token.toString());
                      if (res != false) {
                        Navigator.of(context, rootNavigator: true).pop();
                        KRoutes()
                            .push(context, const OrderConfirmationScreen());
                      } else {
                        Navigator.of(context, rootNavigator: true);
                        Fluttertoast.showToast(msg: "Something went wrong");
                      }
                    },
                    color: kDarkPurple,
                    minWidth: double.infinity,
                    textColor: kWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
