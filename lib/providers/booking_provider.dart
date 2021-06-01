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

  Status getStatus(String status) {
    switch (status) {
      case "Status.Scheduled":
        return Status.Scheduled;
      case "Status.Pending":
        return Status.Pending;
      case "Status.Cancelled":
        return Status.Cancelled;
      case "Status.Completed":
        return Status.Completed;
      default:
        return Status.Pending;
    }
  }

  List<Booking> addBookings(List bookings) {
    List<Booking> _loadedBookings = [];
    for (var i = 0; i < bookings.length; i++) {
      final uniqBook = bookings[i] as Map<String, dynamic>;
      final booking = Booking(
        id: uniqBook['booking_id'],
        hours: uniqBook['hours'],
        price: double.parse(uniqBook['cost']),
        sId: uniqBook['service_id'].toString(),
        date: DateTime.parse(
          uniqBook['date'],
        ),
        status: getStatus(uniqBook['status']),
        time: uniqBook['time'],
        uId: uniqBook['user_id'].toString(),
      );
      _loadedBookings.add(booking);
    }
    return _loadedBookings;
  }

  Future<void> fetchBookings() async {
    final url = Uri.parse("http://192.168.1.20:5000/booking");
    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as List<dynamic>;
      final myBookings = addBookings(extractedData);
      _bookings = myBookings;
    }
    notifyListeners();
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
    _dateTime = booking.date;
    _bookId = booking.id;
    _status = Status.Pending;

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(
        {
          'sId': _sId,
          'uId': _uId,
          'price': _estimatedCost.toString(),
          'date': _dateTime.toIso8601String(),
          'bookid': _bookId,
          'status': _status.toString(),
          'hours': booking.hours,
        },
      ),
    );

    notifyListeners();
  }
}
