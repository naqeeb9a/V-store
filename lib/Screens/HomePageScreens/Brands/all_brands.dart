import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Api/api.dart';
import 'package:store/Screens/HomePageScreens/Categories/categories_shimmer.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/widgets.dart';

import '../../../utils/colors.dart';
import '../DetailPage/detail_list.dart';

class AllBrands extends StatefulWidget {
  const AllBrands({Key? key}) : super(key: key);

  @override
  State<AllBrands> createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
  final ScrollController _scrollController = ScrollController();

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;
  int number = 2;
  bool isMounted = true;
  int loadingPages = 2;
  List dataArray = [];
  getBrandsNow({int page = 1}) async {
    if (isMounted) {
      setState(() {
        if (page == 1) {
          _isFirstLoadRunning = true;
        } else {
          loadingPages = 4;
          _isLoadMoreRunning = true;
        }
      });
    }
    var data = await Api().getBrands(page: page);

    if (data != false) {
      if (data["data"].length != 0) {
        dataArray.addAll(data["data"]);
      } else {
        if (isMounted) {
          setState(() {
            loadingPages = 0;
          });
        }

        Fluttertoast.showToast(msg: "No More Results Found");
      }
    }
    if (isMounted) {
      setState(() {
        if (page == 1) {
          _isFirstLoadRunning = false;
        } else {
          if (loadingPages != 0) {
            loadingPages = 2;
          }
          _isLoadMoreRunning = false;
        }
      });
    }
  }

  @override
  void initState() {
    getBrandsNow();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBrandsNow(page: number++);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    isMounted = false;
    _scrollController.removeListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBrandsNow(page: number++);
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Brands",
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const CustomSearch(text: "Search grocery"),
            const CustomText(
              text: "All Brands",
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: _isFirstLoadRunning
                  ? const CategoriesShimmer()
                  : AnimationLimiter(
                      child: GridView.builder(
                        controller: _scrollController,
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
                        itemCount: dataArray.length + loadingPages,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 10,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: index >= dataArray.length
                                    ? _isLoadMoreRunning
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: kWhite,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[300]!,
                                              ),
                                            ))
                                        : Container()
                                    : InkWell(
                                        onTap: () {
                                          KRoutes().push(context, DetailList(
                                            future: () async {
                                              return await Api()
                                                  .getBrandProducts(
                                                dataArray[index]["id"]
                                                    .toString(),
                                              );
                                            },
                                          ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.network(
                                                "http://vstore.kissancorner.pk/public/" +
                                                    dataArray[index]["logo"],
                                                fit: BoxFit.cover,
                                                height: 60,
                                              ),
                                              SizedBox(
                                                  height: 20,
                                                  child: CustomText(
                                                    text: dataArray[index]
                                                        ["name"],
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
