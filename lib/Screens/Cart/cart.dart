import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/Cart/summary.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Functionality/functionality.dart';

class Cart extends StatefulWidget {
  final bool backEnabled;
  const Cart({Key? key, required this.backEnabled}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List updatedCart = [].obs;
  @override
  void initState() {
    refreshCart = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    return Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          title: "Cart",
          automaticallyImplyLeading: widget.backEnabled,
          widgets: [
            Obx((() {
              return updatedCart.isNotEmpty
                  ? GestureDetector(
                      onTap: () async {
                        EssentialFunctions.loader(context);
                        List cartIds = [];
                        List cartQuantities = [];
                        for (var element in updatedCart) {
                          cartIds.add(element["id"]);
                          cartQuantities.add(element["qty"]);
                        }
                        var res = await Api().updateCartItem(
                            user!.token.toString(),
                            cartIds.join(","),
                            cartQuantities.join(","));
                        if (res != false) {
                          Navigator.of(context, rootNavigator: true).pop();
                          updatedCart.clear();
                          setState(() {});
                          Fluttertoast.showToast(msg: "Cart updated");
                        } else {
                          Navigator.of(context, rootNavigator: true);
                          Fluttertoast.showToast(msg: "Something went wrong");
                        }
                      },
                      child: Icon(
                        Icons.save_outlined,
                        color: kDarkPurple,
                      ))
                  : const Center();
            }))
          ],
          appBarHeight: 70,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
              future: Api().getUserCart(user!.token.toString()),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              "assets/emptyCart.json",
                              width: MediaQuery.of(context).size.width / 3,
                              repeat: false,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const CustomText(text: "Cart is Empty"),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    snapshot.data[0]["cart_items"].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return cartCards(context, index,
                                      snapshot.data[0]["cart_items"], user);
                                },
                              ),
                            ),
                            CustomButton(
                              text: "Checkout",
                              function: () {
                                KRoutes().push(
                                    context,
                                    SummaryScreen(
                                      ownerId: snapshot.data[0]["owner_id"]
                                          .toString(),
                                    ));
                              },
                              color: kDarkPurple,
                              minWidth: double.infinity,
                              textColor: kWhite,
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              }),
        ));
  }

  String getTotal(List cartItems) {
    double total = 0;
    for (var element in cartItems) {
      total += double.parse(element["price"].toString());
    }
    return total.toStringAsFixed(0);
  }

  cartCards(context, index, cartItems, User user) {
    int qtyValue = cartItems[index]["quantity"];
    return Slidable(
      endActionPane:
          ActionPane(extentRatio: 0.2, motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (value) async {
            EssentialFunctions.loader(context);
            var res = await Api().deleteCartItem(
                user.token.toString(), cartItems[index]["id"].toString());
            if (res != false) {
              Navigator.of(context, rootNavigator: true).pop();
              setState(() {});
              Fluttertoast.showToast(msg: "item deleted");
            } else {
              Navigator.of(context, rootNavigator: true);
              Fluttertoast.showToast(msg: "Something went wrong");
            }
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: CupertinoIcons.delete,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://vstore.kissancorner.pk/public/" +
                                cartItems[index]["product_thumbnail_image"]
                                    .toString()))),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: CustomText(
                      text: cartItems[index]["product_name"].toString(),
                      alignment: Alignment.centerLeft,
                      alignText: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: "Rs. " + cartItems[index]["price"].toString(),
                    textColor: kDarkPurple,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: CustomText(
                        text: cartItems[index]["variation"].toString()),
                  ),
                ],
              ),
            ],
          ),
          StatefulBuilder(builder: (context, changeState) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (qtyValue > 1) {
                      changeState(() {
                        qtyValue--;
                      });
                      final index1 = updatedCart.indexWhere((element) =>
                          element["id"] == cartItems[index]["id"].toString());
                      if (index1 == -1) {
                        updatedCart.add({
                          "id": cartItems[index]["id"].toString(),
                          "qty": qtyValue.toString()
                        });
                      } else {
                        updatedCart[index1]["qty"] = qtyValue.toString();
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: kGrey.withOpacity(0.3),
                    child: const Icon(
                      CupertinoIcons.minus,
                      color: kBlack,
                      size: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: "$qtyValue"),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    changeState(() {
                      qtyValue++;
                    });
                    final index1 = updatedCart.indexWhere((element) =>
                        element["id"] == cartItems[index]["id"].toString());
                    if (index1 == -1) {
                      updatedCart.add({
                        "id": cartItems[index]["id"].toString(),
                        "qty": qtyValue.toString()
                      });
                    } else {
                      updatedCart[index1]["qty"] = qtyValue.toString();
                    }
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: kDarkPurple,
                    child: const Icon(
                      CupertinoIcons.plus,
                      color: kWhite,
                      size: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
