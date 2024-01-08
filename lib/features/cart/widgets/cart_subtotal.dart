import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/search/screens/search_screen.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartsubtotal extends StatefulWidget {
  const Cartsubtotal({super.key});

  @override
  State<Cartsubtotal> createState() => _CartsubtotalState();
}

class _CartsubtotalState extends State<Cartsubtotal> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;

    user.cart.map((e) => sum += e['quantity'] * e['product']['price'] as int).toList();

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "\$$sum",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold 
            ),
          )
        ],
      ),
    );
  }
}
