import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/provider/cart_provider.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List? cartItems = Provider.of<CartProvider>(context).cartItems;
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "My Orders",
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
            child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: cartItems == null
                    ? const Center(
                        child: Text("No Order history"),
                      )
                    : Column(
                        children: cartItems.map((e) => Container()).toList(),
                      )),
          ),
        ),
      ),
    );
  }
}
