import 'package:flutter/material.dart';
import 'package:store/Screens/Cart/cart.dart';
import 'package:store/Screens/HomePageScreens/detail_list.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: noColor,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => KRoutes().pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                  heroTag: "animated",
                  backgroundColor: kWhite,
                  child: const Icon(
                    Icons.shopping_basket,
                    color: kPink,
                  ),
                  elevation: 0.1,
                  onPressed: () {
                    KRoutes().push(context, const Cart());
                  }),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    childAspectRatio: 16 / 18,
                    mainAxisSpacing: 20),
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => KRoutes().push(context, const DetailList()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kGrey.withOpacity(0.4),
                          ),
                          height: 90,
                          child: Image.asset(
                            "assets/vegetable.png",
                            width: 70,
                          ),
                        ),
                        const Text("Vegetables")
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
