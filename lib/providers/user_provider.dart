import 'package:amazon_clone/models/users.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      email: '',
      id: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
