import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final String image;
  const Product({super.key, required this.image});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(widget.image,fit: BoxFit.fitHeight,width: 180,),
        ),
      ),
    );
  }
}
