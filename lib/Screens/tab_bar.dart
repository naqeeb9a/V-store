import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:store/Screens/HomePageScreens/home_page.dart';
import 'package:store/Screens/ProfileScreen/profile.dart';
import 'package:store/Screens/messages.dart';
import 'package:store/utils/colors.dart';

import 'OrderScreen/order_screen.dart';

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
    const Profile()
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
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        snakeViewColor: kPink,
        selectedItemColor: kWhite,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'microphone'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'search')
        ],
      ),
      body: Stack(
          children: screens // this variable screens have all the three screens
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
    );
  }
}
