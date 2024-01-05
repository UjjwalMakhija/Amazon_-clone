import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/Initial_buttons.dart';
import 'package:amazon_clone/features/account/widgets/below_appbar.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                  padding: const  EdgeInsets.only(right: 15,left: 15),
                  child: const Row(
                  
                    children:  [
                 Padding(
                   padding:  EdgeInsets.only(right: 15),
                   child: Icon(Icons.notifications_none_sharp),
                 ),
                 Icon(Icons.search_outlined)
                    ]
                  )
                )
              ],
            ),
          )),
   body: Column(
    children: const[

      BelowwappBar(),
      SizedBox(height: 10,),
      Initial_buttons(),
      SizedBox(height: 20,),
      Orders(),

    ],
   ),
    );
  }
}
