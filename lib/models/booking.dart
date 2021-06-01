import 'package:flutter/material.dart';

enum Status {
  Scheduled,
  Pending,
  Completed,
  Cancelled,
}

class Booking {
  final String id;
  final String sId;
  final String uId;
  final DateTime date;
  final TimeOfDay time;
  final double price;
  final Status status;
  final int hours;

  Booking({
    this.id,
    this.sId,
    this.uId,
    this.time,
    this.date,
    this.price,
    this.status = Status.Pending,
    this.hours,
  });

  set status(Status stat) {
    this.status = stat;
  }
}
