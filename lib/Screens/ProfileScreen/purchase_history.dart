import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/widgets/widgets.dart';

import '../../Model/user_model.dart';
import '../../provider/user_data_provider.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "My Orders",
          appBar: AppBar(),
          widgets: const [],
          automaticallyImplyLeading: true,
          appBarHeight: 50),
      body: FutureBuilder(
        future: Api().getPurchaseHistory(user!.token.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data["data"].length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    "assets/emptyOrders.json",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(text: "No orders yet!")
                ],
              );
            } else {
              return const CustomText(text: "Available");
            }
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
