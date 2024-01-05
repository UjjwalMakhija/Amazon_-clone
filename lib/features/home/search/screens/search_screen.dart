import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/search/services/search_services.dart';
import 'package:amazon_clone/features/home/search/widgets/search_product.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/productdetails/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchquery;
  const SearchScreen({super.key, required this.searchquery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product12>? products;
  final SearchServices searchservices = SearchServices();

  void initState() {
    super.initState();
    fetchsearchedproducts();
  }

  void fetchsearchedproducts() async {
    products =
        await searchservices.fetchsearchedproducts(context, widget.searchquery);
    setState(() {});
  }

  void navigateToSearchScren(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appbarGradient,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScren,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.search_sharp,
                                    color: Colors.black,
                                    size: 23,
                                  )),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                )),
                            hintText: "Search Amazon.in",
                            hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  )),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ],
              ),
            )),
        body: products == null
            ? const Loader()
            : Column(
                  children: [
                    const AddressBox(),

                    //
                    const SizedBox(
                      height: 10,
                    ),
                   Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchProduct(
                          product: products![index],
                        ),
                      );
                    },
                  ),
                ),
                  ],
                ),
              
              );
  }
}
