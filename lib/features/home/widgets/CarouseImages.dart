import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({super.key});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(viewportFraction: 1,height:200),
      items: GlobalVariables.carouselimages.map((i)  {
        return Builder(builder: (BuildContext context) =>
          Image.network(i,
          fit: BoxFit.cover,
          height: 200,),
        
        
        );
        
      }
      ).toList()
    );
  }
}
