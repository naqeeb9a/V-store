import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    return Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          title: "Cart",
          automaticallyImplyLeading: true,
          widgets: const [],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(text: "Price"),
                                CustomText(
                                  text:
                                      getTotal(snapshot.data[0]["cart_items"]),
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
                                  text: "Rs. 50",
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
                                  text: "0 %",
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
                                const CustomText(text: "Total"),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Rs. ",
                                      textColor: kBlack.withOpacity(0.3),
                                    ),
                                    CustomText(
                                      text: getTotal(
                                          snapshot.data[0]["cart_items"]),
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
                                  text: "✔️ Copoun Applied",
                                  textColor: kDarkPurple,
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
                            CustomButton(
                              text: "Checkout",
                              function: () {},
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
    int qtyValue = 1;
    return Slidable(
      endActionPane:
          ActionPane(extentRatio: 0.2, motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (value) async {
            // CoolAlert.show(context: context, type: CoolAlertType.loading);
            // await Api().updateCart(user.token.toString(),
            //     cartItems[index]["product_id"].toString(), "0");
            // Navigator.of(context, rootNavigator: true).pop();
            // setState(() {});
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
