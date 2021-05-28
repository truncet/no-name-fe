import 'package:flutter/material.dart';

import './auth_provider.dart';

class Service with ChangeNotifier {
  String _name;
  String _price;
  String _userName;
  String _phone;
  String token;
  String _location;

  void update(AuthProvider tok, Service service) async {
    await tok.autoToken();
    token = tok.token;
    _userName = service == null ? '' : service._userName;
    _location = service == null ? '' : service._location;
    _phone = service == null ? '' : service._phone;
    _name = service == null ? '' : service._name;
    _price = service == null ? '' : service._price;
  }
}
