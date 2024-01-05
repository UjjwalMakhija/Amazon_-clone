import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://images.unsplash.com/photo-1515378960530-7c0da6231fb1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515378960530-7c0da6231fb1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515378960530-7c0da6231fb1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    // "assets/images/lapi.avif",
    // "assets/images/lapi.avif",
    // "assets/images/lapi.avif",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 17),
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          height: 170,
         
          child: ListView.builder(
             scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Product(image: list[index]);
            },
            itemCount: list.length,
          ),
        )
      ],
    );
  }
}
