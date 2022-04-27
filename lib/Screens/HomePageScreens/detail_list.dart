import 'package:flutter/material.dart';
import 'package:store/widgets/DetailListWidgets/detail_cards.dart';

import '../../utils/app_routes.dart';
import '../../utils/colors.dart';

class DetailList extends StatelessWidget {
  const DetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: noColor,
        elevation: 0,
        title: const Text(
          "Detail",
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => KRoutes().pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                  heroTag: "animated",
                  backgroundColor: kWhite,
                  child: const Icon(
                    Icons.shopping_basket,
                    color: kPink,
                  ),
                  elevation: 0.1,
                  onPressed: () {}),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 16 / 21,
                    mainAxisSpacing: 20),
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return const DetailCards();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
