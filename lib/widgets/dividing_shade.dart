import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DividingShade extends StatelessWidget {
  const DividingShade({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 15,
          width: double.infinity,
          color: kGrey.withOpacity(0.2),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}