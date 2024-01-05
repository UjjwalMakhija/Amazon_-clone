import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowwappBar extends StatefulWidget {
  const BelowwappBar({super.key});

  @override
  State<BelowwappBar> createState() => _BelowwappBarState();
}

class _BelowwappBarState extends State<BelowwappBar> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    String name = user.name;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
      decoration: const BoxDecoration(gradient: GlobalVariables.appbarGradient),
      child: RichText(
          text: TextSpan(
              text: "Hello ,",
              style: TextStyle(fontSize: 22, color: Colors.black),
              children: [
            TextSpan(
              text: name,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ]
          )
          ),
    );
  }
}
