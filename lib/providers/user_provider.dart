import 'package:flutter/cupertino.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _userModel!;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _userModel = user;
    notifyListeners();
  }
}
