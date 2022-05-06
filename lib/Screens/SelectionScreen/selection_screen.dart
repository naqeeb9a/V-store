import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/HomePageScreens/home_page.dart';
import 'package:store/provider/store_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/widgets.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: "Choose a V-Store",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: "where you want to shop from",
              fontSize: 15,
            ),
            const SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                {
                  "name": "V-Grocer",
                  "image": "assets/grocer.png",
                  "color": Colors.green,
                  "page": HomePage(),
                  "check": false
                },
                {
                  "name": "V-Fresh",
                  "image": "assets/fresh.png",
                  "color": Colors.teal,
                  "page": HomePage(),
                  "check": false
                },
                {
                  "name": "V-Doc",
                  "image": "assets/medicine.png",
                  "color": Colors.brown,
                  "page": null,
                  "check": true
                },
                {
                  "name": "V-Frozen",
                  "image": "assets/frozen.png",
                  "color": Colors.indigo,
                  "page": null,
                  "check": true
                },
                {
                  "name": "V-Beauty",
                  "image": "assets/beauty.png",
                  "color": Colors.red,
                  "page": Null,
                  "check": true
                },
              ]
                  .map((dynamic e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            InkWell(
                              onTap: () {
                                if (e["page"] != null) {
                                  Provider.of<StoreProvider>(context,
                                          listen: false)
                                      .updateSelectedStore(e["name"]);
                                  KRoutes().push(context, e["page"]);
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: e["color"].withOpacity(0.15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: e["name"].toString(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: "View all >".toString(),
                                          textColor: e["color"],
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        e["image"].toString(),
                                        width: 140,
                                        height: 130,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: e["check"],
                              child: Image.asset(
                                "assets/coming_soon.png",
                                width: 100,
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    ));
  }
}
