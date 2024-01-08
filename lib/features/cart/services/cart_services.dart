import 'dart:convert';
import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/users.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart ' as http;

class CartDetailServices {
  void removefromCart({
    required BuildContext context,
    required Product12 product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );
      httperrorhandler(
          response: res,
          context: context,
          success: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserfrommodel(user);
          });
    } catch (e) {
      print(e.toString());
      showsnackbar(context, e.toString());
    }
  }

  void rateproduct(
      {required BuildContext context,
      required Product12 product,
      required double rating}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json ; charset=utf-8',
            'x-auth-token': userprovider.user.token
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));

      httperrorhandler(response: res, context: context, success: () {});
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
