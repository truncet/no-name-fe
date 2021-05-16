import 'package:flutter/material.dart';

import '../widgets/profile/profile_form.dart';
import '../widgets/app-bar/logout_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoutAppBar(
        appBar: AppBar(),
        title: Text('Complete Profile'),
      ),
      body: ProfileForm(),
    );
  }
}
