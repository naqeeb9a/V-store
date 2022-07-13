import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DisplaySlider extends StatelessWidget {
  final List list;
  const DisplaySlider({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160.0,
        viewportFraction: 1,
      ),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage(i), fit: BoxFit.cover)),
            );
          },
        );
      }).toList(),
    );
  }
}
