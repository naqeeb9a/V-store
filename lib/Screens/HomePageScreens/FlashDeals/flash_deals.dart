import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/widgets/widgets.dart';

import '../../../utils/colors.dart';

class FlashDeals extends StatelessWidget {
  const FlashDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    List<Color> colors = [
      Colors.amber,
      Colors.green,
      Colors.red,
      Colors.deepOrange,
      Colors.indigo,
      Colors.brown,
      Colors.purple,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.blue
    ];
    return Scaffold(
      appBar: BaseAppBar(
          title: "All offers",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const CustomSearch(
              text: "Search grocery",
              enable: false,
            ),
            const CustomText(
              text: "All Offers",
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                future: Api().getFlashDeals(user!.token.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AnimationLimiter(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 16 / 11,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemCount: snapshot.data["data"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 10,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors[Random().nextInt(10)],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        CustomText(
                                          text: snapshot.data["data"][index]
                                              ["title"],
                                          alignment: Alignment.centerLeft,
                                          textColor: kWhite,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomText(
                                              text: "10% Sale",
                                              textColor: kWhite,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            Image.network(
                                              "http://vstore.kissancorner.pk/public/${snapshot.data["data"][index]["banner"]}",
                                              height: 60,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  } else {
                    return animatedList();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  animatedList() {
    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 11,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 10,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: kWhite,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]!,
                        ),
                      )),
                ),
              ));
        },
      ),
    );
  }
}
