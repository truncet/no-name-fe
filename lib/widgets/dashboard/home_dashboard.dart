import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/service_provider.dart';
import './../service-item.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ServiceProvider>(context, listen: false).fetchServices();
    return FutureBuilder(
      future:
          Provider.of<ServiceProvider>(context, listen: false).fetchServices(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataSnapshot.error != null) {
          return Center(child: Text('There is an Error'));
        } else {
          return Consumer<ServiceProvider>(
              builder: (ctx, serviceData, child) => ListView.builder(
                    itemBuilder: (ctx, index) {
                      return ServiceItem(
                        price: serviceData.services[index].price,
                        userName: serviceData.services[index].profile.userName,
                        work: serviceData.services[index].name,
                        workType: serviceData.services[index].workType,
                      );
                    },
                    itemCount: serviceData.services.length,
                  ));
        }
      },
    );
  }
}
