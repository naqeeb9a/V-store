import 'package:flutter/material.dart';
import 'package:store/utils/app_routes.dart';

import '../utils/colors.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final AppBar appBar;
  final bool automaticallyImplyLeading;
  final List<Widget> widgets;
  final double appBarHeight;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.widgets,
      this.automaticallyImplyLeading = false,
      this.backgroundColor = noColor,
      required this.appBarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: noColor,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: kWhite),
        ),
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: true,
        leading: InkWell(
          onTap: () => KRoutes().pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
        ),
        actions: widgets,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
