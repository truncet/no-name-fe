import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './auth_provider.dart';
import './../models/profile.dart';
import './../models/service.dart';

class ServiceProvider with ChangeNotifier {
  String _name;
  String _price;
  String _userName;
  String _phone;
  String token;
  String _location;

  List<Service> _services = [];

  List<Service> get services {
    return _services;
  }

  void update(AuthProvider tok, ServiceProvider service) async {
    await tok.autoToken();
    token = tok.token;
    _userName = service == null ? '' : service._userName;
    _location = service == null ? '' : service._location;
    _phone = service == null ? '' : service._phone;
    _name = service == null ? '' : service._name;
    _price = service == null ? '' : service._price;
  }

  List<Service> getMyListObject(List extractedData) {
    List<Service> serviceDataExtracted = [];
    for (var i = 0; i < extractedData.length; i++) {
      final service = extractedData[i] as Map<String, dynamic>;
      final userProfile = service["user"];
      final profile = Profile(
        age: userProfile['age'],
        userName: userProfile['username'],
        id: userProfile['public_id'],
        phone: userProfile['phone'],
        profession: userProfile['profession'],
        email: userProfile['email'],
        location: userProfile['location'],
      );
      final serviceData = Service(
        id: service['id'].toString(),
        name: service['name'],
        price: service['price'] + 0.0,
        userId: service['user_id'].toString(),
        workType: service['work_type'],
        profile: profile,
      );
      serviceDataExtracted.add(serviceData);
    }
    return serviceDataExtracted;
  }

  Future<void> fetchServices() async {
    final url = Uri.parse("http://192.168.1.20:5000/service/getall");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        final serviceDataExtracted = getMyListObject(extractedData);
        _services = serviceDataExtracted;
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return;
    //print(json.decode(response.bo));
  }
}
