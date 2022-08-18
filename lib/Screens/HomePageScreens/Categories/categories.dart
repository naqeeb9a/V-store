import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/HomePageScreens/Categories/categories_shimmer.dart';
import 'package:store/provider/sub_category_provider.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/custom_text.dart';
import 'package:store/widgets/search.dart';

import '../DetailPage/detail_list.dart';

class CategoriesScreen extends StatefulWidget {
  final bool backButton;
  const CategoriesScreen({Key? key, this.backButton = false}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Categories",
        automaticallyImplyLeading: widget.backButton,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const CustomSearch(
              text: "Search grocery",
              enable: false,
            ),
            const CustomText(
              text: "All Categories",
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: FutureBuilder(
                    future: Api().getCategories(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AnimationLimiter(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 16 / 11,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: snapshot.data["data"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 10,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailList(
                                                      future: () async {
                                                        return await Api()
                                                            .getCategoriesProducts(
                                                                snapshot.data[
                                                                        "data"]
                                                                        [index]
                                                                        ["id"]
                                                                    .toString());
                                                      },
                                                      filterItemsList: snapshot
                                                                  .data["data"]
                                                              [index]
                                                          ["sub_categories"],
                                                    ))).then((value) => context
                                            .read<SubCategoryProvider>()
                                            .resetSubCategory());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kGrey.withOpacity(0.3)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.network(
                                              snapshot.data["data"][index]
                                                          ["icon"] ==
                                                      ""
                                                  ? "https://commercial.bunn.com/img/image-not-available.png"
                                                  : "http://vstore.kissancorner.pk/public/" +
                                                      snapshot.data["data"]
                                                          [index]["icon"],
                                              fit: BoxFit.cover,
                                              height: 60,
                                            ),
                                            SizedBox(
                                                height: 20,
                                                child: CustomText(
                                                  text: snapshot.data["data"]
                                                      [index]["name"],
                                                  fontSize: 12,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const CategoriesShimmer();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
