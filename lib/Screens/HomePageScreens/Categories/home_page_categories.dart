import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Api/api.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_text.dart';

import '../DetailPage/detail_list.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (snapshot.data["data"] as List)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        KRoutes().push(
                            context,
                            DetailList(
                              future: () async {
                                return await Api()
                                    .getCategoriesProducts(e["id"].toString());
                              },
                              filterItemsList: e["sub_categories"],
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(5),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kGrey.withOpacity(0.3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              e["icon"] == ""
                                  ? "https://commercial.bunn.com/img/image-not-available.png"
                                  : "http://vstore.kissancorner.pk/public/" +
                                      e["icon"],
                              fit: BoxFit.cover,
                              height: 60,
                            ),
                            SizedBox(
                                height: 40,
                                child: CustomText(
                                  text: e["name"],
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return const HomePageCategoriesShimmer();
        }
      },
    );
  }
}

class HomePageCategoriesShimmer extends StatelessWidget {
  const HomePageCategoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [1, 2, 3, 4, 5, 6]
            .map(
              (e) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: kWhite,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: kGrey),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
