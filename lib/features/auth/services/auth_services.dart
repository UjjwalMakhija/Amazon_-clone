import 'dart:convert';

import 'package:amazon_clone/commom/widgets/bottom_Bar.dart';
import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/users.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authservice {
  void Signupuser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          email: email,
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      httperrorhandler(
          response: res,
          context: context,
          success: () {
            showsnackbar(
                context, 'Account created ,Login with the same credentials');
          });
    } catch (e) {
      print(e.toString());
      showsnackbar(context, e.toString());
    }
  }

  void SignInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      print(res.body);
      httperrorhandler(
          response: res,
          context: context,
          success: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamed(context, BottomBar.routeName);
          });
    } catch (e) {
      print('Error during sign-in: $e');
      showsnackbar(context, 'An error occurred during sign-in.');
    }
  }

  void getUserdata({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenres = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json;chaset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenres.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json;chaset=UTF-8',
            'x-auth-token': token,
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print('Error during sign-in: $e');
      showsnackbar(context, 'An error occurred during sign-in.');
    }
  }
}
