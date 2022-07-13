import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Choices extends StatelessWidget {
  final List filters;
  const Choices({Key? key, required this.filters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: filters
          .map((e) => Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: kDarkPurple,
                  ),
                  color: kDarkPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                e["name"],
                style:
                    TextStyle(color: kDarkPurple, fontWeight: FontWeight.bold),
              )))
          .toList(),
    );
  }
}
