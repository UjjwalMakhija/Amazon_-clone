import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});
  void updatepg(int page) {}

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarwidth = 42;
  double bottomBarborderwidth = 5;
  List<Widget> Pages = [
    const HomeScreen(),
     AccountScreen(),
    Center(
        child: Container(
      child: Text("Cart"),
    ))
  ];

  void updatepg(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatepg,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.unselectedNavBarColor,
                            width: bottomBarborderwidth))),
                child: Icon(Icons.home_rounded),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.white,
                            width: bottomBarborderwidth))),
                child: Icon(Icons.person_pin),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.white,
                            width: bottomBarborderwidth))),
                child: badges.Badge(
                  child: Icon(Icons.shopping_cart),
                  badgeContent: const Text("2"),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                ),
              ),
              label: ''),
        ],
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
      ),
    );
  }
}
