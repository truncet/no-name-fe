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
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) return _token;
  }

  Future<void> _signUp(String email, String password, String userName) async {
    _authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(_authResult);
    final post_url = Uri.parse("http://127.0.0.1/user");
    //final response = await http.post(post_url)
  }
}
