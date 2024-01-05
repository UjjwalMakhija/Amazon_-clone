import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class Dealoftheday extends StatefulWidget {
  const Dealoftheday({super.key});

  @override
  State<Dealoftheday> createState() => _DealofthedayState();
}

class _DealofthedayState extends State<Dealoftheday> {
  Product12? product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealofDay();
  }

  void fetchDealofDay() async {
    product = await homeServices.fetchDealofDay(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "\$1100",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "Apple MacBook Pro (13.3 ich,M1 chip with 8)",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10)
                            .copyWith(left: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: product!.images
                                .map(
                                  (e) => Image.network(
                                    e,
                                    fit: BoxFit.fitWidth,
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      child: Text(
                        "See All Deals",
                        style: TextStyle(
                            fontSize: 17,
                            color: GlobalVariables.selectedNavBarColor),
                      ),
                    ),
                  ],
                ),
              );
  }
}
