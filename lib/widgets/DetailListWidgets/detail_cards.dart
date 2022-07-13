import 'package:flutter/material.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/animated_plus.dart';
import 'package:store/widgets/custom_text.dart';

import '../../utils/colors.dart';

class DetailCards extends StatefulWidget {
  final int heroTag;
  const DetailCards({Key? key, required this.heroTag}) : super(key: key);

  @override
  State<DetailCards> createState() => _DetailCardsState();
}

class _DetailCardsState extends State<DetailCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            InkWell(
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
            // const Positioned(
            //   right: 0,
            //   // child: AddToWishList(),
            // ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            const AnimatedCounter()
          ],
        )
      ],
    );
  }
}
