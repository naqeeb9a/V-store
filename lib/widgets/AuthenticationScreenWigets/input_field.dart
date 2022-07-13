
import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

class InputFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final int length;
  final IconData icons;
  const InputFormFeild(
      {Key? key,
      required this.controller,
      this.length = 15,
      this.type = TextInputType.text,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kDarkPurple,
            ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLength: length,
        cursorColor: kDarkPurple,
        decoration: InputDecoration(
            prefixIconColor: kDarkPurple,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            fillColor: kGrey.withOpacity(0.3),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.3),
              ),
              gapPadding: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.3),
              ),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.3),
              ),
              gapPadding: 10,
            ),
            focusColor: kDarkPurple,
            iconColor: kDarkPurple,
            suffixIconColor: kDarkPurple,
            counter: const Text(""),
            suffixIcon: Icon(icons)),
      ),
    );
  }
}
