import 'package:flutter/material.dart';

class buttons extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const buttons({super.key, required this.text, required this.onTap});

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration:
            BoxDecoration(
              border: Border.all(color: Colors.white, width: 0),
              borderRadius: BorderRadius.circular(50)
              ),
        child: OutlinedButton(
          style:  ElevatedButton.styleFrom(
            primary:  Colors.black.withOpacity(0.03),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50))
          ),
          onPressed: widget.onTap, child: Text(widget.text,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),)),
      ),
    );
  }
}
