import 'package:flutter/material.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/detail_page.dart';
import 'package:store/widgets/custom_button.dart';

import '../../utils/app_routes.dart';
import '../../utils/colors.dart';
import '../custom_text.dart';

class DealCards extends StatelessWidget {
  final List items;
  const DealCards({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: items
          .map((e) => InkWell(
                onTap: () => KRoutes().push(
                    context,
                    DetailPage(
                      data: e,
                    )),
                child: Container(
                  height: 250,
                  width: 160,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kGrey.withOpacity(0.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Image.asset(e["image"].toString(), height: 90),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomText(
                          text: e["name"].toString(),
                          alignment: Alignment.centerLeft,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomText(
                          text: e["main_price"].toString(),
                          alignment: Alignment.centerLeft,
                          fontSize: 20,
                        ),
                      ),
                      CustomButton(
                        text: "Add to cart",
                        function: () {
                          showModelSheet(context, e);
                        },
                        color: kDarkPurple,
                        minWidth: 120,
                        textFontSize: 20,
                        height: 40,
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
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
        var item = ["1kg", "2kg"];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Select size",
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                      onTap: () => KRoutes().pop(context),
                      child: const Icon(Icons.close))
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: item.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: kGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(e["image"].toString()))),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: e["name"].toString(),
                          alignment: Alignment.centerLeft,
                          fontSize: 25,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: item[index],
                          alignment: Alignment.centerLeft,
                          fontSize: 20,
                          textColor: kBlack.withOpacity(0.6),
                        ),
                      ],
                    ),
                    CustomButton(
                      text: "Add to cart",
                      function: () {},
                      color: kDarkPurple,
                      height: 30,
                      minWidth: 50,
                    )
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
