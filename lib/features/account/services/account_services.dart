import 'dart:convert';
import 'dart:js';

import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:provider/provider.dart';

class AccountServices {
  Future<List<Order>> fetchallorders({
    required BuildContext context,
    required String category
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'content-type': 'application/json; charset: utf-8',
        'x-auth-token': userprovider.user.token,
      },
      );

      httperrorhandler(response: res, context: context, success: (){
         for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
      });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return orderList;
  }
}
