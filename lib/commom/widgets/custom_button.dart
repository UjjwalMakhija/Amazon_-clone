import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Custom_button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
   final Color? color;
  const Custom_button({super.key, required this.text, required this.onTap, this.color=GlobalVariables.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
        color: color ==null ? Colors.white :Colors.black
      ),),
      onPressed:onTap ,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity,50),
        backgroundColor: color,
      ),
    );
  }
}
