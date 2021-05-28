import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String id;
  final String userName;
  final String email;
  final String location;
  final String profession;
  final String phone;
  final int age;
  final bool profileComleted = false;

  Profile({
    this.id,
    this.userName,
    this.profession,
    this.email,
    this.location,
    this.phone,
    this.age,
  });
}
