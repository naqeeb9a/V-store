import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

import '../custom_text.dart';

class RowText extends StatelessWidget {
  final String text1, text2;
  final bool visibility;
  final void Function()? function;
  const RowText(
      {Key? key,
      required this.text1,
      required this.visibility,
      this.text2 = "Show all",
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text1,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          alignment: Alignment.topLeft,
        ),
        InkWell(
          onTap: function,
          child: CustomText(
            text: visibility == true ? text2 : "",
            fontSize: 12,
            textColor: kDarkPurple,
          ),
        ),
      ],
    );
  }
}
