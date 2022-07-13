import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../../widgets/custom_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink,
      // extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Add Address",
        widgets: const [],
        appBarHeight: 70,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(20),
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const CustomText(
                            text: "Addresses",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text:
                                "Please add your current address where the product can be delivered",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            controller: _state,
                            hintText: "State",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _city,
                            hintText: "City",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _address,
                            hintText: "Address",
                            prefixIcon: const SizedBox(),
                            suffixIcon: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                      text: "Add Address",
                      function: () {},
                      color: kPink,
                      height: 50,
                      minWidth: double.infinity),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
