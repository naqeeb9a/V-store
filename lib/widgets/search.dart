import 'package:flutter/material.dart';

import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                color: kGrey,
                spreadRadius: 2,
                blurRadius: 2)
          ]),
      padding: const EdgeInsets.all(8),
      child: CustomTextField(
        controller: null,
        label: "Search your daily grocery food ...",
        hintText: "Search the place ..",
        keyboardType: TextInputType.text,
        prefixIcon: Icon(
          Icons.search_outlined,
          color: kBlack.withOpacity(0.5),
        ),
        suffixIcon: const Icon(
          Icons.search_outlined,
          color: noColor,
        ),
      ),
    );
  }
}
