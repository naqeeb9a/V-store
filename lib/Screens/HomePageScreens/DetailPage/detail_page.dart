import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/Cart/cart.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/wishlist_animation.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/DetailListWidgets/detail_page_shimmer.dart';
import 'package:store/widgets/dividing_shade.dart';
import 'package:store/widgets/widgets.dart';

import '../../../Functionality/functionality.dart';
import '../../../utils/app_routes.dart';

class DetailPage extends StatelessWidget {
  final Map data;
  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    return FutureBuilder(
      future: Api().checkIfInWishList(
          data["id"].toString(), user!.id.toString(), user.token.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return details(context, user, snapshot.data["is_in_wishlist"]);
        } else {
          return const DetailPageShimmer();
        }
      },
    );
  }

  Widget details(BuildContext context, User? user, bool check) {
    int? selectedVariant;
    return StatefulBuilder(builder: (context, changeState) {
      return Scaffold(
        appBar: BaseAppBar(
            title: "Product Detail",
            appBar: AppBar(),
            automaticallyImplyLeading: true,
            widgets: [
              InkWell(
                onTap: () {
                  KRoutes().push(context, const Cart(backEnabled: true,));
                },
                child: Icon(
                  CupertinoIcons.cart,
                  color: kDarkPurple,
                ),
              )
            ],
            appBarHeight: 50),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(color: kWhite, boxShadow: [
            BoxShadow(
                color: kGrey,
                offset: Offset(0, 0),
                spreadRadius: 3,
                blurRadius: 3)
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: CustomText(
                          text: data["name"],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          alignText: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    AddToWishList(
                      productId: data["id"].toString(),
                      userId: user!.id.toString(),
                      token: user.token.toString(),
                      isInWishList: check,
                    )
                  ],
                ),
              ),
              const DividingShade(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const CustomText(
                      text: "Variants",
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          (data["variants"] as List).length,
                          (index) => InkWell(
                            onTap: () {
                              changeState(() {
                                selectedVariant = index;
                              });
                            },
                            child: Container(
                              width: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: selectedVariant == index
                                        ? kDarkPurple
                                        : kBlack.withOpacity(0.6),
                                  ),
                                  color: selectedVariant == index
                                      ? kDarkPurple.withOpacity(0.1)
                                      : kGrey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(5),
                              child: CustomText(
                                text: data["variants"][index]["variant"] == ""
                                    ? "Not Provided"
                                    : data["variants"][index]["variant"],
                                textColor: selectedVariant == index
                                    ? kDarkPurple
                                    : kBlack.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const DividingShade(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs. " + data["price"].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (selectedVariant == null) {
                          Fluttertoast.showToast(msg: "Select a variant first");
                        } else {
                          EssentialFunctions.loader(context);
                          var response = await Api().addToCart(
                              data["id"].toString(),
                              user.id.toString(),
                              user.token.toString(),
                              data["variants"][selectedVariant]["variant"]);
                          if (response.statusCode == 200) {
                            Navigator.of(context, rootNavigator: true).pop();
                            if (refreshCart != null) {
                              refreshCart!();
                            }
                            Fluttertoast.showToast(
                                msg: "Product added to cart");
                          } else {
                            Navigator.of(context, rootNavigator: true).pop();
                            Fluttertoast.showToast(msg: "Try again");
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: kDarkPurple,
                        child: const Icon(
                          CupertinoIcons.cart_badge_plus,
                          color: kWhite,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Image.network(
            "http://vstore.kissancorner.pk/public/" + data["thumbnail_image"],
            fit: BoxFit.cover,
          ),
        )),
      );
    });
  }

  Widget reviewCards() {
    return ListView.builder(
      itemCount: 2,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: const CustomText(text: "⭐ 5")),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(text: "By Angelina"),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: "3 days ago",
                      textColor: kBlack.withOpacity(0.6),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomText(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              maxLines: 5,
              alignText: TextAlign.left,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        );
      },
    );
  }
}
