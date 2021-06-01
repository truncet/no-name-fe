import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/service_provider.dart';
import '../widgets/confirm-booking.dart';

class ServiceDetailScreen extends StatelessWidget {
  static final routeName = "/service-detail-screen";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final serviceData = Provider.of<ServiceProvider>(context, listen: false);
    final service = serviceData.specificService(id);

    final style = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);

    void _showDialog(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return ConfirmBooking(
              service: service,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.pink),
                ),
                margin: EdgeInsets.only(top: 30),
                child: Image.network(
                  "https://bit.ly/2SdPlXv",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: 350,
                child: Column(
                  children: [
                    Text(service.name.toUpperCase(), style: style),
                    SizedBox(height: 4),
                    Text(service.profile.userName.toUpperCase(), style: style),
                    SizedBox(height: 4),
                    Text(service.profile.age.toString(), style: style),
                    SizedBox(height: 4),
                    Text(service.profile.email, style: style),
                    SizedBox(height: 4),
                    Text(service.profile.phone, style: style),
                    SizedBox(height: 4),
                    Text(
                      "${service.price}/${service.workType}".toUpperCase(),
                      style: style,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ButtonTheme(
                      height: 40,
                      minWidth: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _showDialog(context);
                        },
                        child: Text('BOOK'),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
