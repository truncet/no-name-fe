import 'package:flutter/foundation.dart';

class Auth {
  final String userEmail;
  final String userPassword;
  bool isLogin;
  final String role;

  Auth({
    @required this.userEmail,
    @required this.userPassword,
    this.isLogin,
    @required this.role,
  });
}
