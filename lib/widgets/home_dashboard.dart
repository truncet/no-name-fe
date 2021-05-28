import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/service_provider.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('this');
    Provider.of<ServiceProvider>(context, listen: false).fetchServices();
    return Container();
  }
}
