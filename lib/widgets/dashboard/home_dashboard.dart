import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../providers/booking_provider.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookdata = Provider.of<BookServiceProvider>(context, listen: false)
        .fetchBookings();
    return Container();
  }
}
