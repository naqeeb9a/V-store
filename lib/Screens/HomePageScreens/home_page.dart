import 'package:flutter/material.dart';
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/Screens/HomePageScreens/Brands/all_brands.dart';
import 'package:store/Screens/HomePageScreens/Brands/brands.dart';
import 'package:store/Screens/HomePageScreens/Categories/categories.dart';
import 'package:store/Screens/HomePageScreens/Categories/home_page_categories.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/detail_list.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/utils/data.dart';
import 'package:store/widgets/HomeScreenWidgets/display_container.dart';
import 'package:store/widgets/HomeScreenWidgets/product_grid.dart';

import 'package:store/widgets/widgets.dart';

import '../../widgets/HomeScreenWidgets/row_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    homePageAppBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomSearch(
                      text: "Search anything",
                      enable: false,
                    ),
                  ],
                ),
              ),
              const DisplaySlider(
                list: [
                  "https://img.pikbest.com/backgrounds/20210618/pink-grocery-store-online-shopping-promotion-template_6021409.jpg!c1024wm0",
                  "https://thumbs.dreamstime.com/b/isometric-grocery-online-shopping-landing-page-purple-web-banner-supermarket-cart-full-food-drink-stands-screen-mobile-206683878.jpg",
                  "https://thumbs.dreamstime.com/b/volunteer-carrying-food-donation-box-website-landing-page-woman-activist-collecting-grocery-production-homeless-poor-people-162345980.jpg",
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    RowText(
                      text1: "Categories",
                      visibility: true,
                      function: () {
                        KRoutes().push(context, const CategoriesScreen());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const HomePageCategories(),
                    const SizedBox(
                      height: 15,
                    ),
                    const RowText(
                      text1: "Big Offers",
                      visibility: true,
                      text2: "All Offers",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    bigOffersCard(),
                    const SizedBox(
                      height: 15,
                    ),
                    RowText(
                      text1: "Brands",
                      visibility: true,
                      function: () {
                        KRoutes().push(context, const AllBrands());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Brands(),
                    const SizedBox(
                      height: 15,
                    ),
                    RowText(
                        text1: "Best Selling",
                        visibility: true,
                        text2: "All products",
                        function: () {
                          KRoutes().push(context, DetailList(future: () async {
                            return await Api().getProducts();
                          }));
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ProductGrid(
                      future: () async {
                        return await Api().getBestSellingProducts();
                      },
                      shrinkWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesWidget(String selectedStore) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: (categoriesList[selectedStore] as List)
            .map(
              (e) => InkWell(
                onTap: () {
                  // KRoutes().push(
                  //     context,
                  //     const DetailList(
                  //         // filters: e["categories"],
                  //         ));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kGrey.withOpacity(0.3)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        e["image"] ?? "assets/baby.png",
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      SizedBox(
                          height: 40,
                          child: CustomText(
                            text: e["name"],
                            fontSize: 12,
                          ))
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  homePageAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const CustomText(
              text: "Hello Naqeeb!",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: "Check out some fresh veggies",
              fontSize: 12,
              textColor: kBlack.withOpacity(0.6),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                EssentialFunctions().makePhoneCall("+923353961478");
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: kDarkPurple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.phone_outlined,
                    color: kDarkPurple,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                EssentialFunctions().sendWhatsappMessage("+923353961478");
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: kDarkPurple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.whatsapp_outlined,
                    color: kDarkPurple,
                  )),
            ),
          ],
        )
      ],
    );
  }

  bigOffersCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          {
            "name": "Fresh Eggs",
            "image": "eggs.png",
            "discount": "50%",
            "color": Colors.orange
          },
          {
            "name": "All kinds of Snacks",
            "image": "snacks.png",
            "discount": "10%",
            "color": Colors.teal
          },
          {
            "name": "Bakery's all goodies",
            "image": "bakery.png",
            "discount": "20%",
            "color": Colors.red
          },
        ]
            .map((dynamic e) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                      color: e["color"],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 1,
                      ),
                      CustomText(
                        text: e["name"],
                        alignment: Alignment.centerLeft,
                        textColor: kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: e["discount"] + " Sale",
                            textColor: kWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          Image.asset(
                            "assets/${e["image"]}",
                            height: 60,
                          )
                        ],
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
