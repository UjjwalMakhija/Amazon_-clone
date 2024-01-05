import 'package:amazon_clone/features/account/widgets/button.dart';
import 'package:flutter/material.dart';

class Initial_buttons extends StatefulWidget {
  const Initial_buttons({super.key});

  @override
  State<Initial_buttons> createState() => _Initial_buttonsState();
}

class _Initial_buttonsState extends State<Initial_buttons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buttons(text: "Your Orders", onTap: (){}),
            buttons(text: "Turn Seller", onTap: (){})
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            buttons(text: "Log Out", onTap: (){}),
            buttons(text: "Your Wish List", onTap: (){})
          ],
        )

      ],
    );
  }
}