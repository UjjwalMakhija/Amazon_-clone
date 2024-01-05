import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httperrorhandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback success,
}) {
  switch (response.statusCode) {
    case 200:
      success();
      break;
    case 400:
      showsnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showsnackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showsnackbar(context, response.body);
  }
}
