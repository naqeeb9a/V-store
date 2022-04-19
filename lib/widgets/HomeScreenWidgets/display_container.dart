import 'package:flutter/material.dart';
import 'package:store/Screens/HomePageScreens/categories.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';

class DisplayContainer extends StatelessWidget {
  final String text, text1, text2, image;
  final double width, height;
  const DisplayContainer(
      {Key? key,
      required this.text,
      required this.text1,
      required this.text2,
      this.width = 90,
      this.height = 90,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration:
          BoxDecoration(color: kWhite, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text),
                InkWell(
                    onTap: () =>
                        KRoutes().push(context, const CategoriesScreen()),
                    child: Text(text1))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kPink.withOpacity(0.1),
                      ),
                      height: height,
                      width: width,
                      child: Image.asset(
                        image,
                        width: width - 20,
                      ),
                    ),
                    Text(text2)
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
