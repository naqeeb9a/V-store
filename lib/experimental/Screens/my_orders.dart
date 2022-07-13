import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool check = false;
  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "My Orders",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "All Orders"),
                DropdownButton<String>(
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return orderCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const CustomText(text: "Order 52421654"),
            const CustomText(text: "Placed on 30 July 2021"),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  {
                    "name": "Tomato",
                    "model": "Shipped",
                    "url":
                        "https://cdn.imgbin.com/17/19/8/imgbin-single-pumpkin-pumpkin-ZcLepkMyzrgWLhMmLpaA077GJ.jpg",
                  },
                  {
                    "name": "Onion",
                    "model": "Shipped",
                    "url":
                        "https://cdn.imgbin.com/17/19/8/imgbin-single-pumpkin-pumpkin-ZcLepkMyzrgWLhMmLpaA077GJ.jpg",
                  },
                  {
                    "name": "Cucumber",
                    "model": "Delivered",
                    "url":
                        "https://cdn.imgbin.com/17/19/8/imgbin-single-pumpkin-pumpkin-ZcLepkMyzrgWLhMmLpaA077GJ.jpg",
                  },
                  {
                    "name": "Carrot",
                    "model": "Shipped",
                    "url":
                        "https://cdn.imgbin.com/17/19/8/imgbin-single-pumpkin-pumpkin-ZcLepkMyzrgWLhMmLpaA077GJ.jpg",
                  },
                  {
                    "name": "Apple",
                    "model": "Shipped",
                    "url":
                        "https://cdn.imgbin.com/17/19/8/imgbin-single-pumpkin-pumpkin-ZcLepkMyzrgWLhMmLpaA077GJ.jpg",
                  },
                ].map((dynamic i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  i["url"],
                                  height: 40,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  i["name"],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: "Poppins"),
                                ),
                                Text(
                                  i["model"],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ]);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
