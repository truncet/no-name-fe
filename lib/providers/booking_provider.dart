import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './auth_provider.dart';
import '../models/booking.dart';

class BookServiceProvider with ChangeNotifier {
  String token;
  String _sId;
  String _uId;
  double _estimatedCost;
  DateTime _dateTime;
  String _status;

  List<Booking> _bookings = [];

  void update(AuthProvider tok, BookServiceProvider service) async {
    await tok.autoToken();
    token = tok.token;
    _sId = service == null ? '' : service._sId;
    _uId = service == null ? '' : service._uId;
    _estimatedCost = service == null ? '' : service._estimatedCost;
    _dateTime = service == null ? '' : service._dateTime;
    _status = service == null ? '' : service._status;
  }

  Future<void> fetchBookings() async {}

  Future<void> bookServices(
    String id,
    String uId,
    double price,
  ) async {
    final url = Uri.parse("http://192.168.1.20:5000/booking/");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(url,
        headers: headers,
        body: json.encode({
          'id': id,
          'uId': uId,
          'price': price.toString(),
        }));
    notifyListeners();
  }
}
