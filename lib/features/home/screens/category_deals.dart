import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/productdetails/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDeals extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String categoryname;
  const CategoryDeals({super.key, required this.categoryname});

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product12>? products;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryproducts();
  }

  fetchCategoryproducts() async {
    products =
        await homeServices.fetchCategoryproducts(context, widget.categoryname);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appbarGradient,
            ),
          ),
          title: Text(
            widget.categoryname,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Text(
                    "Keep shopping for ${widget.categoryname}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: products!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = products![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 5,
                                  right: 15,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
