import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign alignText;
  final int maxLines;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  const CustomText(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.fontSize,
      this.alignText = TextAlign.center,
      this.maxLines = 2,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignText,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
