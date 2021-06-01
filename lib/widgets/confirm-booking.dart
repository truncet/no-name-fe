import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_name/providers/booking_provider.dart';
import 'package:provider/provider.dart';

import './../screens/book-status-screen.dart';
import './../models/service.dart';
import './../models/booking.dart';
import './../providers/auth_provider.dart';

class ConfirmBooking extends StatefulWidget {
  final Service service;

  ConfirmBooking({this.service});

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  DateTime _selectedDate;
  int _hours = 0;

  void _presentDatePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 30),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _confirmBooking(BuildContext ctx) {
    if (_hours <= 0 || _selectedDate == null) {
      return;
    }
    final _uId = Provider.of<AuthProvider>(ctx, listen: false).userId;
    final _booking = Booking(
      id: DateTime.now().toIso8601String(),
      price: widget.service.price,
      sId: widget.service.id,
      uId: _uId,
      time: _selectedDate,
      hours: _hours,
    );
    Provider.of<BookServiceProvider>(ctx, listen: false).bookServices(_booking);
    Navigator.of(ctx).pushReplacementNamed(BookStatusScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Job",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.service.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.service.profile.userName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Estimated Hours:-",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: _hours == 0
                        ? null
                        : () {
                            setState(() {
                              _hours -= 1;
                            });
                          },
                  ),
                  Text(
                    _hours.toString(),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_outlined),
                    onPressed: _hours >= 12
                        ? null
                        : () {
                            setState(() {
                              _hours += 1;
                            });
                          },
                  )
                ],
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date Choosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        _presentDatePicker(context);
                      },
                    )
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.time_to_leave),
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).errorColor),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _confirmBooking(context);
                      },
                      child: Text("Confirm")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
