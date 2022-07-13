import 'package:flutter/material.dart';
import 'package:store/Screens/Search/search_screen.dart';
import 'package:store/utils/app_routes.dart';

import 'package:store/utils/colors.dart';

class CustomSearch extends StatelessWidget {
  final String text;
  final bool enable;
  final TextEditingController? controller;
  final dynamic function;
  const CustomSearch(
      {Key? key,
      required this.text,
      this.enable = true,
      this.controller,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: kGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.search_outlined,
                color: kDarkPurple,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: enable == false
                    ? InkWell(
                        onTap: () =>
                            KRoutes().push(context, const SearchScreen()),
                        child: TextFormField(
                          enabled: enable,
                          decoration: InputDecoration(
                              hintText: text, border: InputBorder.none),
                        ),
                      )
                    : TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: text,
                            border: InputBorder.none),
                        onSubmitted: (value) async {
                          await function();
                        },
                      ),
              ),
            ]));
  }
}
