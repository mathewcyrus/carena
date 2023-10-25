import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/models/user.dart' as model;
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  model.User? _user;
  final _authmethods = AuthMethods();

  model.User get getUser => _user!;

  Future<void> refreshUserDetails() async {
    model.User? newUser = await _authmethods.getUserDetails();

    // Compare the new user details with the existing user details
    if (_user != newUser) {
      _user = newUser;
      notifyListeners();
    }
  }
}
