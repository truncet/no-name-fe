import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  DateTime _expiryDate;
  String _userId;
  UserCredential _authResult;
  final _auth = FirebaseAuth.instance;
  String _token;

  String get userId {
    return _auth.currentUser.uid;
  }

  String get token {
    print(_token);
    return _token;
  }

  Future<void> signUp(String email, String password, String role) async {
    _authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _token = await _auth.currentUser.getIdToken();
    final post_url = Uri.parse("http://192.168.1.20:5000/user/");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $_token'
    };
    final response = await http.post(post_url,
        headers: headers,
        body: json.encode({
          "role": role,
        }));
    notifyListeners();
    //final response = await http.post(post_url)
  }

  Future<void> signIn(String email, String password) async {
    _authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _token = await _auth.currentUser.getIdToken();
    notifyListeners();
  }

  Future<String> autoToken() async {
    _token = _auth.currentUser == null || _auth == null
        ? null
        : await _auth.currentUser.getIdToken();
    return _token;
  }
}
