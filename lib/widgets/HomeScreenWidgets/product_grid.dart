import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/detail_page.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/HomeScreenWidgets/product_grid_shimmer.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_text.dart';

import '../../Screens/Cart/cart.dart';
import '../../utils/colors.dart';

class ProductGrid extends StatefulWidget {
  final Function future;
  final bool shrinkWrap;
  final bool isWishList;
  const ProductGrid(
      {Key? key,
      required this.future,
      this.shrinkWrap = false,
      this.isWishList = false})
      : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final ScrollController _scrollController = ScrollController();

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;
  bool isMounted = true;
  int number = 2;
  int loadingPages = 2;
  List dataArray = [];
  getBrandsNow({int page = 1}) async {
    CustomCounter.updateValue(page);

    if (isMounted) {
      setState(() {
        if (page == 1) {
          _isFirstLoadRunning = true;
        } else {
          loadingPages = 4;
          _isLoadMoreRunning = true;
        }
      });
    }

    var data = await widget.future();

    if (data != false) {
      if (data["data"].length != 0) {
        dataArray.addAll(data["data"]);
      } else {
        if (isMounted) {
          setState(() {
            loadingPages = 0;
          });
        }
        Fluttertoast.showToast(msg: "No More Results Found");
      }
    }
    if (isMounted) {
      setState(() {
        if (page == 1) {
          _isFirstLoadRunning = false;
        } else {
          if (loadingPages != 0) {
            loadingPages = 2;
          }
          _isLoadMoreRunning = false;
        }
      });
    }
  }

  @override
  void initState() {
    getBrandsNow();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBrandsNow(page: number++);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    isMounted = false;
    _scrollController.removeListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBrandsNow(page: number++);
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        getBrandsNow();
      },
      color: kDarkPurple,
      showChildOpacityTransition: false,
      child: _isFirstLoadRunning
          ? const ProductGridShimmer()
          : dataArray.isEmpty
              ? widget.isWishList
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          "assets/emptyFav.json",
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomText(text: "No Products in WishList"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: "Refresh",
                          function: () {
                            getBrandsNow();
                          },
                          color: kDarkPurple,
                          textColor: kWhite,
                        )
                      ],
                    )
                  : const CustomText(text: "No Products Found")
              : animatedGrid(dataArray),
    );
  }

  animatedGrid(dynamic dataArray) {
    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        shrinkWrap: widget.shrinkWrap,
        controller: _scrollController,
        physics: widget.shrinkWrap
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 25,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemCount: dataArray.length + (widget.shrinkWrap ? 0 : loadingPages),
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 10,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: index >= dataArray.length
                    ? _isLoadMoreRunning
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: kWhite,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300]!,
                              ),
                            ))
                        : Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => KRoutes().push(
                                context,
                                DetailPage(
                                  data: dataArray[index],
                                )),
                            child: Image.network(
                              "http://vstore.kissancorner.pk/public/" +
                                  dataArray[index]["thumbnail_image"]
                                      .toString(),
                              height: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                          CustomText(
                            text: dataArray[index]["name"].toString(),
                            fontSize: 14,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            text: "Rs. " + dataArray[index]["price"].toString(),
                            textColor: kDarkPurple,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(5)),
                            child: CustomText(
                                text:
                                    dataArray[index]["unit"] ?? "Not Provided"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () =>
                                showModelSheet(context, dataArray[index]),
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
            ),
          );
        },
      ),
    );
  }

  showModelSheet(context, e) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        User? user = Provider.of<UserDataProvider>(context).user;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Select Variant",
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: () {
                      KRoutes().push(context, const Cart());
                    },
                    child: Icon(
                      CupertinoIcons.cart,
                      color: kDarkPurple,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: e["variants"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.2,
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e["variants"][index]
                                                  ["image"] ==
                                              ""
                                          ? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"
                                          : "http://vstore.kissancorner.pk/public/" +
                                              e["variants"][index]["image"]
                                                  .toString()))),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomText(
                                    text: e["name"].toString(),
                                    alignment: Alignment.centerLeft,
                                    alignText: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                  text: "Rs. " +
                                      e["variants"][index]["price"].toString(),
                                  textColor: kDarkPurple,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: CustomText(
                                      text: e["variants"][index]["variant"] ==
                                              ""
                                          ? "Not Provided"
                                          : e["variants"][index]["variant"] ??
                                              "Not Provided"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                barrierDismissible: false);
                            var response = await Api().addToCart(
                                e["id"].toString(),
                                user!.id.toString(),
                                user.token.toString(),
                                e["variants"][index]["variant"]);
                            if (response.statusCode == 200) {
                              Navigator.of(context, rootNavigator: true).pop();
                              Fluttertoast.showToast(
                                  msg: "Product added to cart");
                            } else {
                              Navigator.of(context, rootNavigator: true).pop();
                              Fluttertoast.showToast(msg: "Try again");
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
