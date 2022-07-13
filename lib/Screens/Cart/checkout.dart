import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/Screens/Cart/add_addresses.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../widgets/custom_button.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List? cartItems = Provider.of<CartProvider>(context).cartItems;
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Checkout",
        widgets: const [],
        appBarHeight: 70,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          // cartItems == null
                          // ? Column(
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.only(
                          //             top: 20, left: 20, right: 20),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             const CustomText(
                          //               text: "Addresses",
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //             GestureDetector(
                          //               onTap: () {
                          //                 KRoutes().push(
                          //                     context, const AddAddress());
                          //               },
                          //               child: const CustomText(
                          //                 text: "Add new",
                          //                 textColor: kPink,
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       const Divider(
                          //         color: kBlack,
                          //       ),
                          //       const Spacer(),
                          //       const Center(
                          //         child:
                          //             Text("No addresses added at this point"),
                          //       ),
                          //       const Spacer(),
                          //     ],
                          //   )
                          // :
                          Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(text: "Addresses"),
                                GestureDetector(
                                  onTap: () {
                                    KRoutes().push(context, const AddAddress());
                                  },
                                  child: const CustomText(
                                    text: "Add new",
                                    textColor: kPink,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: kBlack,
                          ),
                          Column(
                            children: [1, 0]
                                .map((e) => addressListWidget(isSelected: e))
                                .toList(),
                          ),
                        ],
                      )),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(text: r"Total : $567"),
                      CustomButton(
                        text: "Checkout",
                        function: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          width: double.infinity,
                                          child: LottieBuilder.asset(
                                            "assets/order.json",
                                            repeat: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const CustomText(
                                          text: "Order Successfull",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const CustomText(
                                          text:
                                              "Your Order #4655895 is successfully placed",
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                            text: "Track my Order",
                                            function: () {},
                                            color: kPink),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const CustomText(
                                          text: "Go Back",
                                          textColor: kPink,
                                        )
                                      ]),
                                );
                              });
                        },
                        color: kPink,
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addressListWidget({isSelected = 0}) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: kBlack),
          borderRadius: BorderRadius.circular(10)),
      child: RadioListTile(
        value: 1,
        groupValue: isSelected,
        onChanged: (value) {},
        title:
            const CustomText(text: "house no 98, street 4, model town, lahore"),
        subtitle: const CustomText(text: "+92332455543"),
      ),
    );
  }
}
