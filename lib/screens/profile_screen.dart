import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile/profile_form.dart';
import '../widgets/app-bar/logout_app_bar.dart';

import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    return Scaffold(
      appBar: LogoutAppBar(
        appBar: AppBar(),
        title: Text('Complete Profile'),
      ),
      body: ProfileForm(),
    );
  }
}
