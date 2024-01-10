import 'dart:convert';
import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/users.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveuseraddress({
    required BuildContext context,
    required String address,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: jsonEncode({'address': address}),
      );

      httperrorhandler(
          response: res,
          context: context,
          success: () {
            User user1 =
                user.user.copyWith(address: jsonDecode(res.body)['address']);
            user.setUserfrommodel(user1);
          });
    } catch (e) {
      print('sus $e');
      showsnackbar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      print(userprovider.user.cart);
      print(userprovider.user.token);
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'content-type': 'application/json ; charset=utf-8',
            'x-auth-token': userprovider.user.token,
          },
          body: jsonEncode({
            'cart': userprovider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));
      httperrorhandler(
          response: res,
          context: context,
          success: () {
            showsnackbar(context, 'Your order has been placed successfully');
            User user = userprovider.user.copyWith(
              cart: [],
            );
            userprovider.setUserfrommodel(user);
          });
    } catch (e) {
      print(address);
      print('$totalSum');
      print('1  $e');
      showsnackbar(context, e.toString());
    }
  }

  void deleteProduct(
      {required context, required product, required onSuccess}) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json;charset=UTF-8',
                'x-auth-token': user.user.token,
              },
              body: jsonEncode({
                'id': product.id,
              }));

      httperrorhandler(
          response: res,
          context: context,
          success: () {
            onSuccess();
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }
}
