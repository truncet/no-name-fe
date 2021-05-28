import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './auth_provider.dart';

import './../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  String _userName;
  int _age;
  String _profession;
  String _location;
  String _phone;
  String token;
  bool _profileCompleted = false;

  int get age {
    return _age;
  }

  String get location {
    return _location;
  }

  String get phone {
    return _phone;
  }

  bool get profileCompleted {
    return _profileCompleted;
  }

  void update(AuthProvider tok, ProfileProvider profile) async {
    await tok.autoToken();
    token = tok.token;
    _userName = profile == null ? '' : profile._userName;
    _age = profile == null ? -1 : profile._age;
    _profession = profile == null ? '' : profile._profession;
    _location = profile == null ? '' : profile._location;
    _profileCompleted = profile == null ? '' : profile._profileCompleted;
  }

  void printToken() {
    print(token);
  }

  Future<void> fetchProfile() async {
    final url = Uri.parse("http://192.168.1.20:5000/user/profile");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(url, headers: headers);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    return;
    final usableData = extractedData[0] as Map<String, dynamic>;
    print(usableData);
  }

  void sendProfile(Profile profile) async {
    _userName = profile.userName;
    _age = profile.age;
    _profession = profile.profession;
    _location = profile.location;
    _phone = profile.location;
    final put_url = Uri.parse("http://192.168.1.20:5000/user/profile");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.put(put_url,
        headers: headers,
        body: json.encode({
          'username': _userName,
          'age': _age,
          'profession': _profession,
          'location': _location,
          'phone': _phone,
        }));
    notifyListeners();
    return;
  }
}
