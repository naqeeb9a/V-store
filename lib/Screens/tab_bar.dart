import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:store/Screens/HomePageScreens/Categories/categories.dart';

import 'package:store/Screens/HomePageScreens/home_page.dart';
import 'package:store/Screens/ProfileScreen/profile.dart';
import 'package:store/Screens/notification.dart';
import 'package:store/utils/colors.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  //list of screen to display through navigation bar
  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const CategoriesScreen(),
      const NotificationsScreen(),
      const Profile()
    ];
  }

  //This index will indicate the selected index of the bottom nav bar

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_alt),
        title: ("Home"),
        iconSize: 20,
        activeColorPrimary: kDarkPurple,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.list_bullet),
        title: ("Settings"),
        iconSize: 20,
        activeColorPrimary: kDarkPurple,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bell),
        title: ("Home"),
        iconSize: 20,
        activeColorPrimary: kDarkPurple,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Settings"),
        iconSize: 20,
        activeColorPrimary: kDarkPurple,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      navBarHeight: 50,
      screens: _buildScreens(),
      items: _navBarsItems(),
      bottomScreenMargin: 50,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
