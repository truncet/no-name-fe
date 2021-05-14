import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/auth/auth_form.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String role,
    bool isLogin,
    BuildContext ctx,
  ) async {
    try {
      final authData = Provider.of<Auth>(context, listen: false);
      print(authData);
      setState(() {
        _isLoading = true;
      });
      if (!isLogin) {
        await authData.signUp(email, password, role);
      } else {
        await authData.signIn(email, password);
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occured, please check your credentials!';

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (_) {
      print('platformException');
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
