import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/tab_bar.dart';
import 'package:store/provider/store_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/utils/data.dart';
import 'package:store/widgets/widgets.dart';

class StoreSelection extends StatelessWidget {
  const StoreSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(
                    text: "Select the store where\n you want to shop",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: allStores
                        .map((e) => InkWell(
                            onTap: () {
                              Provider.of<StoreProvider>(context, listen: false)
                                  .updateSelectedStore(e["name"]);
                              kDarkPurple = e["color"];
                              KRoutes().push(context, const CustomTabBar());
                            },
                            child: storeListBuilder(
                                context, e["image"], e["name"])))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget storeListBuilder(BuildContext context, String image, String text) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: kGrey.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                width: 80,
              ),
              const SizedBox(
                width: 20,
              ),
              CustomText(
                text: text,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ],
      ),
    );
  }
}
