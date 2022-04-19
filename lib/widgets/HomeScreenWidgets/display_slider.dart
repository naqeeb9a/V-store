import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

class DisplaySlider extends StatelessWidget {
  const DisplaySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List images = [
      "https://i.pinimg.com/originals/ef/81/00/ef8100cfcf584de09f75a1c3944e22b3.jpg",
      "https://previews.123rf.com/images/elenabsl/elenabsl1603/elenabsl160300017/54060490-grocery-shopping-discount-paper-shopping-bag-filled-with-vegetables-fruits-and-other-products.jpg",
      "https://i.ytimg.com/vi/nf06gJ4hg60/maxresdefault.jpg"
    ];
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            height: 160,
            width: 300,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(images[index]), fit: BoxFit.cover)),
          );
        },
      ),
    );
  }
}
