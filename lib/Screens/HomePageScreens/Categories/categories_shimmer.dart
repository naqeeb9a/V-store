import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/utils/colors.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
