import 'package:flutter/material.dart';
import 'package:no_name/screens/dashboard_screen.dart';

class BookStatusScreen extends StatelessWidget {
  static final routeName = "/booking-status";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Status'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(DashboardScreen.routeName);
          },
        ),
      ),
    );
  }
}
