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
  Status _status;
  String _bookId;

  List<Booking> _bookings = [];

  List<Booking> get bookings {
    return _bookings;
  }

  void update(AuthProvider tok, BookServiceProvider service) async {
    await tok.autoToken();
    token = tok.token;
    _sId = service == null ? '' : service._sId;
    _uId = service == null ? '' : service._uId;
    _estimatedCost = service == null ? '' : service._estimatedCost;
    _dateTime = service == null ? '' : service._dateTime;
    _status = service == null ? '' : service._status;
  }

  void addBookings(String response) {}

  Future<void> fetchBookings() async {
    final url = Uri.parse("http://192.168.1.20:5000/booking");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      addBookings(response.body);
    }

    print(json.decode(response.body));
  }

  Future<Booking> bookServices(
    Booking booking,
  ) async {
    final url = Uri.parse("http://192.168.1.20:5000/booking/");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    _estimatedCost = booking.price * booking.hours;
    _sId = booking.sId;
    _uId = booking.uId;
    _dateTime = booking.time;
    _bookId = booking.id;
    _status = Status.Pending;

    final response = await http.post(url,
        headers: headers,
        body: json.encode({
          'sId': _sId,
          'uId': _uId,
          'price': _estimatedCost.toString(),
          'date': _dateTime.toIso8601String(),
          'bookid': _bookId,
          'status': _status.toString(),
        }));
    if (response.statusCode == 200) {
      notifyListeners();
      return booking;
      //_addNewBooking(booking);
    }
    notifyListeners();
    return Booking();
  }
}
