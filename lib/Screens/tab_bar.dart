import 'package:flutter/material.dart';
import 'package:store/Screens/HomePageScreens/home_page.dart';
import 'package:store/Screens/messages.dart';
import 'package:store/Screens/notification.dart';
import 'package:store/Screens/orders.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/BottomNavBarWidgets/custom_bottom_nav_bar_painter.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  //list of screen to display through navigation bar

  List<Widget> screens = [
    const HomePage(),
    const OrdersScreen(),
    const MessagesScreen(),
    const NotificationsScreen()
  ];

  //This index will indicate the selected index of the bottom nav bar

  int _selectedIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Stack(
              children:
                  screens // this variable screens have all the three screens
                      .asMap() // this will read this screen variable as map
                      .map(
                        // this will map all items from the screens variable
                        (kNum, widget) => MapEntry(
                          kNum,
                          Offstage(
                            offstage: _selectedIndex != kNum,
                            //this will check if the selected icon on the navigation bar is not equal to provided number and will hide the screen behind
                            child:
                                widget, //this will build the child wigdet coming from screens variable one by one
                          ),
                        ),
                      )
                      .values
                      .toList()),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        heroTag: "animated",
                        backgroundColor: kPink,
                        child: const Icon(
                          Icons.shopping_basket,
                          color: kWhite,
                        ),
                        elevation: 0.1,
                        onPressed: () {}),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? kPink
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.restaurant_menu,
                              color: _selectedIndex == 1
                                  ? kPink
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                            }),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: _selectedIndex == 2
                                  ? kPink
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(2);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: _selectedIndex == 3
                                  ? kPink
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(3);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),

      // Container(
      //   height: 50, //to make the height constant on all screens
      //   decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      //     boxShadow: [
      //       BoxShadow(
      //           offset: Offset(1, 1),
      //           color: kGrey,
      //           spreadRadius: 2,
      //           blurRadius: 2)
      //     ],
      //   ),
      //   child: ClipRRect(
      //     borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      //     child: BottomNavigationBar(
      //       backgroundColor: kWhite,
      //       type: BottomNavigationBarType.fixed,
      //       selectedItemColor: kDarkPink,
      //       selectedFontSize: 10.0,
      //       unselectedFontSize: 10.0,
      //       _selectedIndex: _selectedIndex,
      //       onTap: (i) => setState(() {
      //         _selectedIndex = i;
      //       }),
      //       items: const [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home_outlined),
      //           activeIcon: Icon(Icons.home),
      //           label: "Home",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.explore_outlined),
      //           activeIcon: Icon(Icons.explore),
      //           label: "Explore",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.person_outline),
      //           activeIcon: Icon(Icons.person),
      //           label: "Profile",
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
