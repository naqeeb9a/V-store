import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/HomePageScreens/DetailPage/detail_list.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class Brands extends StatelessWidget {
  const Brands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().getBrands(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == false) {
            return const CustomText(text: "Not working");
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (snapshot.data["data"] as List)
                    .map((e) => brandsCard(context, e))
                    .toList(),
              ),
            );
          }
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [1, 2, 3, 4, 5, 6]
                  .map(
                    (e) => brandsCardShimmer(),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget brandsCard(context, data) {
    return InkWell(
      onTap: () {
        KRoutes().push(context, DetailList(
          future: () async {
            return await Api().getBrandProducts(data["id"].toString());
          },
        ));
      },
      child: Container(
        height: 100,
        width: 90,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              "http://vstore.kissancorner.pk/public/" + data["logo"],
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 50, child: CustomText(text: data["name"]))
          ],
        ),
      ),
    );
  }

  Widget brandsCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: kWhite,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]!),
      ),
    );
  }
}
