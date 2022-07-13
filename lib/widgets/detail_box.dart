import 'package:flutter/cupertino.dart';
import 'package:store/utils/colors.dart';
import 'package:store/utils/dynamic_sizes.dart';
import 'package:store/widgets/widgets.dart';


class DetailBox extends StatelessWidget {
  final String text1, text2;
  const DetailBox({Key? key,required this.text1,required this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: kGrey,
              spreadRadius: 5,
              blurRadius: 25,
              offset: Offset(15, 15)),
        ],
      ),
      width: KSizes().dynamicWidth(context, 0.25),
      height: KSizes().dynamicHeight(context, 0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KSizes().heightBox(context, 0.06),
          CustomText(
            text: text1,
            textColor: kBlue,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
          CustomText(text: text2, textColor: kGrey, fontSize: 16),
          KSizes().heightBox(context, 0.02),
        ],
      ),
    );
  }
}

