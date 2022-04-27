import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/Cart/checkout.dart';
import 'package:store/provider/cart_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../widgets/custom_button.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List? cartItems = Provider.of<CartProvider>(context).cartItems;
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Cart",
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
                      child: cartItems == null
                          ? const Center(
                              child: Text("No items in cart"),
                            )
                          : Column(
                              children:
                                  cartItems.map((e) => Container()).toList(),
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
                        text: "Continue",
                        function: () {
                          KRoutes().push(context, const CheckOut());
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
}
