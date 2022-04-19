import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

import '../utils/dynamic_sizes.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final double minWidth;
  final double height;
  final Color color;
  final Color textColor;
  final double textFontSize;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.function,
      required this.color,
      this.minWidth = 200,
      this.height = 40,
      this.textColor = kWhite,
      this.textFontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: minWidth,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            KSizes().dynamicWidth(context, 1),
          ),
        ),
      ),
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: textFontSize),
      ),
    );
  }
}
