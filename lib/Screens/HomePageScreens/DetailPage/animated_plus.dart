import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

import '../../../widgets/widgets.dart';

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({Key? key}) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> {
  bool isVisible = false;
  double buttonHeigth = 30;
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceOut,
      padding: const EdgeInsets.all(2),
      width: 30,
      height: buttonHeigth,
      decoration: const BoxDecoration(
          color: kPink,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15))),
      duration: const Duration(milliseconds: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              } else {
                setState(() {
                  isVisible = false;
                  buttonHeigth = 30;
                });
              }
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
            child: CustomText(
              text: "$quantity",
              textColor: kWhite,
              fontSize: 15,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                quantity++;
                buttonHeigth = 70;
                Future.delayed(const Duration(milliseconds: 700), () {
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
      ),
    );
  }
}
