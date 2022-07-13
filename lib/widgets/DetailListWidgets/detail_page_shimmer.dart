

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_app_bar.dart';

import '../dividing_shade.dart';

class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Product Detail",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(color: kWhite, boxShadow: [
          BoxShadow(
              color: kGrey,
              offset: Offset(0, 0),
              spreadRadius: 3,
              blurRadius: 3)
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: kWhite,
                    child: Container(
                      color: Colors.grey[300]!,
                      height: 50,
                      width: 200,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: kWhite,
                    child: Container(
                      color: Colors.grey[300]!,
                      height: 50,
                      width: 100,
                    ),
                  )
                ],
              ),
            ),
            const DividingShade(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: kWhite,
                      child: Container(
                        color: Colors.grey[300]!,
                        height: 10,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: (["1", "2", "3"])
                          .map((dynamic e) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: kWhite,
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: kBlack.withOpacity(0.6),
                                      ),
                                      color: Colors.grey[300]!,
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.all(5),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const DividingShade(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: kWhite,
                    child: Container(
                      color: Colors.grey[300]!,
                      height: 50,
                      width: 100,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: kWhite,
                    child: Container(
                      color: Colors.grey[300]!,
                      height: 50,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
