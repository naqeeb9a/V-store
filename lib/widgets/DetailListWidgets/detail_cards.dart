import 'package:flutter/material.dart';
import 'package:store/Screens/HomePageScreens/detail_page.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/custom_text.dart';

import '../../utils/colors.dart';

class DetailCards extends StatefulWidget {
  const DetailCards({Key? key}) : super(key: key);

  @override
  State<DetailCards> createState() => _DetailCardsState();
}

class _DetailCardsState extends State<DetailCards> {
  bool isVisible = false;
  double buttonHeigth = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => KRoutes().push(context, const DetailPage()),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kGrey.withOpacity(0.3),
            ),
            child: Image.asset(
              "assets/meat.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(
                  text: "Vegetables",
                ),
                CustomText(
                  text: "PKR 120",
                  fontSize: 10,
                ),
              ],
            ),
            AnimatedContainer(
                padding: const EdgeInsets.all(2),
                width: 30,
                height: buttonHeigth,
                decoration: const BoxDecoration(
                    color: kPink,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15))),
                duration: const Duration(milliseconds: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = false;
                          buttonHeigth = 30;
                        });
                      },
                      child: Visibility(
                          visible: isVisible,
                          child: const Icon(
                            Icons.remove,
                            color: kWhite,
                          )),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: const CustomText(
                        text: "2",
                        textColor: kWhite,
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          buttonHeigth = 70;
                          Future.delayed(const Duration(milliseconds: 600), () {
                            setState(() {
                              isVisible = true;
                            });
                          });
                        });
                      },
                      child: const CustomText(
                        text: "+",
                        textColor: kWhite,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ))
          ],
        )
      ],
    );
  }
}
