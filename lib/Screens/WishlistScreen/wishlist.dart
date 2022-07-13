import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/widgets/widgets.dart';

import '../../widgets/HomeScreenWidgets/product_grid.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserDataProvider>(context).user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "Favourite Lists",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const CustomSearch(
                  text: "Search in favourite list",
                ),
                Expanded(
                    child: ProductGrid(
                  future: () async {
                    return await Api().getUserWishList(user!.token.toString());
                  },
                  isWishList: true,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
