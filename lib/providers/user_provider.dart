import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final _authmethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUserDetails() async {
    User user = await _authmethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
