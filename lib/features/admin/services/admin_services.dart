import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('djbquejie', 'hi5tdg7h');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path,folder: name));

        imageUrls.add(res.secureUrl);
      }
      Product12 product = Product12(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json;chaset=UTF-8',
            'x-auth-token': user.user.token,
          },
          body: product.toJson());

      httperrorhandler(
          response: res,
          context: context,
          success: () {
            showsnackbar(context, 'Product added successfully ');
            Navigator.pop(context);
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  Future<List<Product12>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product12> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/get-products"), headers: {
        'content-type': 'application/json; charset = utf8',
        'x-auth-token': userProvider.user.token
      });
      httperrorhandler(
          response: res,
          context: context,
          success: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product12.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showsnackbar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required context, required product, required onSuccess}) async  {

           final user = Provider.of<UserProvider>(context, listen: false);
    try {
     
  

      http.Response res = await http.post(Uri.parse('$uri/admin/delete-product'),
          headers: {
            'Content-Type': 'application/json;chaset=UTF-8',
            'x-auth-token': user.user.token,
          },
          body: jsonEncode({
            'id':product.id,
          }
          )
          );

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
