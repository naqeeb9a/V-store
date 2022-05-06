import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/HomePageScreens/categories.dart';
import 'package:store/provider/store_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/utils/data.dart';

class DisplayContainer extends StatelessWidget {
  final String text, text1;
  final double width, height;
  const DisplayContainer({
    Key? key,
    required this.text,
    required this.text1,
    this.width = 90,
    this.height = 90,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedStore = Provider.of<StoreProvider>(context).store;
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration:
          BoxDecoration(color: kWhite, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text),
                InkWell(
                    onTap: () =>
                        KRoutes().push(context, const CategoriesScreen()),
                    child: Text(text1))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categoriesList[selectedStore].length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kGrey.withOpacity(0.3),
                        ),
                        height: height,
                        width: width,
                        child: Image.asset(
                          categoriesList[selectedStore][index]["image"],
                          width: width - 20,
                        ),
                      ),
                      Text(
                        categoriesList[selectedStore][index]["name"],
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
