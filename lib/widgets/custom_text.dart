import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign alignText;
  final int maxLines;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment alignment;
  final double padding;
  const CustomText(
      {Key? key,
      required this.text,
      this.textColor = kBlack,
      this.fontSize = 12,
      this.alignText = TextAlign.center,
      this.maxLines = 2,
      this.fontWeight = FontWeight.normal,
      this.alignment = Alignment.center,
      this.padding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          textAlign: alignText,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
