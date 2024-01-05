import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, _) {
        return 
        Icon(
          Icons.star_border_purple500_outlined,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
