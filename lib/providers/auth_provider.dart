import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  UserCredential _authResult;
  final _auth = FirebaseAuth.instance;

  String get userId {
    return _userId;
  }

  String get token {
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
          'email': email,
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
}
