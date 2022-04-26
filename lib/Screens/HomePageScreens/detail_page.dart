import 'package:flutter/material.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink.withOpacity(0.7),
      // extendBodyBehindAppBar: true,

      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
                left: 20,
                top: 20,
                child: InkWell(
                  onTap: () => KRoutes().pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: kWhite,
                  ),
                )),
            Image.asset(
              "assets/meat.png",
              width: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
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
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomText(
                              text: "Meat",
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomText(text: "Rs. 120"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                CustomText(text: "Rs. 120"),
                                CustomText(text: "14 calories"),
                                CustomText(text: "⭐ 4.5 (257)"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: kPink,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.remove,
                                      color: kWhite,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const CustomText(text: "4 kg"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: kPink,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(
                                      Icons.add,
                                      color: kWhite,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomText(
                              text: "Detail",
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const CustomText(
                                  maxLines: 5,
                                  alignText: TextAlign.left,
                                  text:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
