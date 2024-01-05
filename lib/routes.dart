import 'package:amazon_clone/commom/widgets/bottom_Bar.dart';
import 'package:amazon_clone/features/admin/screens/add_new_product.dart';
import 'package:amazon_clone/features/home/screens/category_deals.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/home/search/screens/search_screen.dart';
import 'package:amazon_clone/features/productdetails/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case auth_screen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const auth_screen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProduct.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProduct());
    case CategoryDeals.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(
                categoryname: category,
              ));
    case SearchScreen.routeName:
      var searchquery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchquery: searchquery,
              ));
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product12;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text(
                    "Error Screen not found or does not exist",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ));
  }
}
