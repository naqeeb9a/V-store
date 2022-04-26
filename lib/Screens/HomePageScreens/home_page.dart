import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/HomeScreenWidgets/display_container.dart';
import 'package:store/widgets/HomeScreenWidgets/display_slider.dart';
import 'package:store/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hey 😊",
                        style: TextStyle(color: kWhite),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "let's search your grocery food.",
                        style: TextStyle(color: kWhite),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 30,
                    foregroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                  )
                ],
              ),
            ),
            const CustomSearch(),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: kGrey,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        DisplayContainer(
                          text: "Categories",
                          text1: "See all",
                          text2: "Vegetables",
                          image: "assets/vegetable.png",
                        ),
                        DisplaySlider(),
                        DisplayContainer(
                          text: "Popular deals",
                          text2: "Meat",
                          text1: "See all",
                          width: 150,
                          height: 120,
                          image: "assets/meat.png",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
