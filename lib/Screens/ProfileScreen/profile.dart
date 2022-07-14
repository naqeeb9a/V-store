import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store/Screens/ProfileScreen/addresses_screen.dart';
import 'package:store/Screens/ProfileScreen/profile_and_security.dart';
import 'package:store/Screens/ProfileScreen/purchase_history.dart';
import 'package:store/Screens/WishlistScreen/wishlist.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../Api/api.dart';
import '../../Model/user_model.dart';
import '../../provider/user_data_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    List itemsList = [
      {
        "icon": Icons.person_outline,
        "text": "Profile & Security",
        "function": () {
          KRoutes().push(context, ProfileAndSecurity(
            function: () {
              setState(() {});
            },
          ));
        }
      },
      {
        "icon": Icons.favorite_outline,
        "text": "Wishlist",
        "function": () {
          KRoutes().push(context, const WishListScreen());
        }
      },
      {
        "icon": Icons.card_travel_outlined,
        "text": "Terms & conditions",
        "function": () {}
      },
      {"icon": Icons.help_outline, "text": "Help Center", "function": () {}},
    ];
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
        appBar: BaseAppBar(
            title: "Account",
            appBar: AppBar(),
            widgets: const [],
            appBarHeight: 50),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 0),
                          spreadRadius: 5,
                          blurRadius: 5,
                          color: kGrey)
                    ], color: kWhite, borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            FutureBuilder(
                              future: Api().getProfile(user!.token.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        foregroundImage: NetworkImage(
                                          "http://vstore.kissancorner.pk/public/${snapshot.data["avatar_original"]}",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: snapshot.data["name"],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      CustomText(
                                        text: snapshot.data["email"],
                                        fontSize: 15,
                                        textColor: kBlack.withOpacity(0.6),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 30,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: kWhite,
                                        child: Container(
                                          height: 20,
                                          width: 100,
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: kWhite,
                                        child: Container(
                                          color: Colors.grey[300]!,
                                          height: 20,
                                          width: 200,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const Divider(
                              color: kBlack,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    KRoutes()
                                        .push(context, const PurchaseHistory());
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.square_list,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                        text: "My Orders",
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.gift,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text: "My Vouchers",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    KRoutes()
                                        .push(context, const AddressesScreen());
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.location,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                        text: "Addresses",
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kBlack),
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                "member",
                                style: TextStyle(color: kWhite),
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: itemsList[index]["function"],
                        child: ListTile(
                          leading: Icon(itemsList[index]["icon"]),
                          title: CustomText(
                            text: itemsList[index]["text"],
                            alignment: Alignment.centerLeft,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: kDarkPurple,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
