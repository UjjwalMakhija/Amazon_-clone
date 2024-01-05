import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class SearchServices {
  Future<List<Product12>> fetchsearchedproducts(
      BuildContext context, String searchquery) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product12> products = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchquery'), headers: {
        'content-Type': 'application/json ,charset = utf-8',
        'x-auth-token': userProvider.user.token
      });
      httperrorhandler(
          response: res,
          context: context,
          success: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products
                  .add(Product12.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return products;
  }
}
