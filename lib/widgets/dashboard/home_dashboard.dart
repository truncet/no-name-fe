import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/service_provider.dart';
import './../service-item.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              builder: (ctx, serviceData, child) => Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (ctx, index) {
                          return ServiceItem(
                            price: serviceData.services[index].price,
                            userName:
                                serviceData.services[index].profile.userName,
                            work: serviceData.services[index].name,
                            workType: serviceData.services[index].workType,
                            id: serviceData.services[index].id,
                          );
                        },
                        itemCount: serviceData.services.length,
                      ),
                    ),
                  ));
        }
      },
    );
  }
}
