import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/WishlistScreen/wishlist.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List itemsList = [
      {
        "icon": Icons.person_outline,
        "text": "Profile & Security",
        "function": () {}
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
                            const CircleAvatar(
                              radius: 30,
                              foregroundImage: NetworkImage(
                                  "https://theundercoverrecruiter.com/wp-content/uploads/2018/09/ian-dooley-281846-unsplash-1-e1537195966706.jpg"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                              text: "Susan J. Patt",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            CustomText(
                              text: "@sapttron",
                              fontSize: 15,
                              textColor: kBlack.withOpacity(0.6),
                            ),
                            const SizedBox(
                              height: 10,
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
                                Column(
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
                                Column(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.location,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text: "Location",
                                      fontSize: 12,
                                    ),
                                  ],
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
