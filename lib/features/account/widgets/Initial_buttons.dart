import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/button.dart';
import 'package:flutter/material.dart';

class Initial_buttons extends StatelessWidget {
  const Initial_buttons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buttons(text: "Your Orders", onTap: () {}),
            buttons(text: "Turn Seller", onTap: () {})
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            buttons(text: "Log Out", onTap: () =>AccountServices().logout(context)),
            buttons(text: "Your Wish List", onTap: () {})
          ],
        )
      ],
    );
  }
}
