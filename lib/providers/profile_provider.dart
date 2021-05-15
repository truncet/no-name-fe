import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile with ChangeNotifier {
  String _userName;
  int _age;
  String _profession;
  String _location;
  String _number;
  String token;

  int get age {
    return _age;
  }

  String get location {
    return _location;
  }

  String get number {
    return _number;
  }

  void update(String tok, Profile profile) {
    token = tok;
    _userName = profile == null ? '' : profile._userName;
    _age = profile == null ? -1 : profile._age;
    _profession = profile == null ? '' : profile._profession;
    _location = profile == null ? '' : profile._location;
    notifyListeners();
  }

  void sendProfile(
    String userName,
    int age,
    String profession,
    String location,
    String number,
  ) async {
    _userName = userName;
    _age = age;
    _profession = profession;
    _location = location;
    _number = number;

    final put_url = Uri.parse("http://192.168.1.20:5000/user/profile");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.put(put_url,
        headers: headers,
        body: json.encode({
          'userName': _userName,
          'age': _age,
          'profession': _profession,
          'location': _location,
          'number': _number,
        }));
    notifyListeners();
    return;
  }
}
