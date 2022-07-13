import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/widgets/HomeScreenWidgets/product_grid.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Api/api.dart';
import '../../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  dynamic futureData;
  getSearchResult() async {
    setState(() {
      loading = true;
    });
    var res = await Api().searchProducts(text: _controller.text);

    setState(() {
      loading = false;
    });

    futureData = res;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              searchHeader(context),
              _controller.text.isEmpty
                  ? const SizedBox()
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: CustomText(text: "Your filter result"),
                    ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _controller.text.isEmpty
                    ? const Center(
                        child: CustomText(text: "Search something"),
                      )
                    : loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : futureData.isEmpty
                            ? onSearchError(context)
                            : Center(
                                child: SingleChildScrollView(
                                  child: ProductGrid(
                                      future: () async {
                                        return futureData;
                                      },
                                      shrinkWrap: true),
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget onSearchError(context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  "assets/noSearch.json",
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const CustomText(
                  text: "Oops!",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text:
                      "The item is not Available Now!\n it may be available so soon, keep shopping",
                  textColor: kBlack.withOpacity(0.6),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomButton(
              text: "Continue Shopping",
              function: () {
                KRoutes().pop(context);
              },
              color: kDarkPurple,
              minWidth: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchHeader(context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            KRoutes().pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kDarkPurple,
            size: 15,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: CustomSearch(
          text: "Search anything",
          controller: _controller,
          function: getSearchResult,
        )),
        const SizedBox(
          width: 10,
        ),
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: kDarkPurple.withOpacity(0.08),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              Icons.phone_outlined,
              color: kDarkPurple,
            )),
      ],
    );
  }
}
