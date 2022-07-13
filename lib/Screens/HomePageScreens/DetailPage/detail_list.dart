import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/Cart/cart.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../../widgets/HomeScreenWidgets/choices.dart';
import '../../../widgets/HomeScreenWidgets/product_grid.dart';

class DetailList extends StatelessWidget {
  final Function future;
  final List? filterItemsList;

  const DetailList({Key? key, required this.future, this.filterItemsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Detail Page",
          automaticallyImplyLeading: true,
          appBar: AppBar(),
          widgets: [
            InkWell(
              onTap: () {
                KRoutes().push(context, const Cart());
              },
              child: Icon(
                CupertinoIcons.cart,
                color: kDarkPurple,
              ),
            )
          ],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            filterItems(filterItemsList ?? []),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ProductGrid(
              future: future,
            )),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget filterItems(List filters) {
    if (filters.isNotEmpty) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Choices(
            filters: filters,
          ));
    } else {
      return Container();
    }
  }
}
