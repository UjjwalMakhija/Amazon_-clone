import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/posts_page.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarwidth = 42;
  double bottomBarborderwidth = 5;
  List<Widget> Pages = [
   Posts(),
    Center(
        child: Container(
      child: Text("Analytics"),
    )),
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
      
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appbarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                Container(
                    // alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: const Text(
                      "Admin",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
            ),
          )),
     
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
                child: Icon(Icons.analytics_outlined),
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
                child: Icon(Icons.move_to_inbox_sharp),
              ),
              label: ''),
        ],
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
      ),
      body: Pages[_page],
    );
  }
}
