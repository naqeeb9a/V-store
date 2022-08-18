import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/sub_category_provider.dart';
import '../../utils/colors.dart';

class Choices extends StatefulWidget {
  final List filters;
  final VoidCallback changeState;
  const Choices({Key? key, required this.filters, required this.changeState})
      : super(key: key);

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    var selectedSubCategory = Provider.of<SubCategoryProvider>(context).id;
    return Wrap(
      children: List.generate(
          widget.filters.length,
          (index) => GestureDetector(
                onTap: () {
                  context.read<SubCategoryProvider>().updateSubCategory(-2);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    context
                        .read<SubCategoryProvider>()
                        .updateSubCategory(widget.filters[index]["id"]);
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color:
                              selectedSubCategory == widget.filters[index]["id"]
                                  ? kDarkPurple
                                  : kBlack,
                        ),
                        color:
                            selectedSubCategory == widget.filters[index]["id"]
                                ? kDarkPurple.withOpacity(0.1)
                                : kWhite,
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          widget.filters[index]["name"],
                          style: TextStyle(
                              color: selectedSubCategory ==
                                      widget.filters[index]["id"]
                                  ? kDarkPurple
                                  : kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )),
    );
  }
}
