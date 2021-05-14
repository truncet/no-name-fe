import 'package:flutter/foundation.dart';

class AuthData {
  final String userEmail;
  final String userName;
  final String userPassword;
  bool isLogin;
  final String role;

  AuthData({
    @required this.userEmail,
    @required this.userName,
    @required this.userPassword,
    this.isLogin,
    @required this.role,
  });
}
