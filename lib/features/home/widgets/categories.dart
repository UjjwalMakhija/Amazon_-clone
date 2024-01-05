import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals.dart';
import 'package:flutter/material.dart';

class Cateegories extends StatefulWidget {
  const Cateegories({super.key});

  @override
  State<Cateegories> createState() => _CateegoriesState();
}

class _CateegoriesState extends State<Cateegories> {
  void NavigatetoCategoryPage(String category, BuildContext context) {
    Navigator.pushNamed(context, CategoryDeals.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: ListView.builder(
          itemExtent: 83,
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryimages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => NavigatetoCategoryPage( GlobalVariables.categoryimages[index]['title']!,context),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryimages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryimages[index]['title']!,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            );
          },
        ));
  }
}
