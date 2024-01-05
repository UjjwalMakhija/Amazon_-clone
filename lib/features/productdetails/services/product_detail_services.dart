import 'dart:convert';
import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart ' as http;

class Productdeatilservices {
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
