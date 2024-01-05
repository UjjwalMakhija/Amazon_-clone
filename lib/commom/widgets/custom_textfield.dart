import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const Customformfield(
      {required this.controller, super.key, required this.hintText,this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
