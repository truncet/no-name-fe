import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Text title;

  LogoutAppBar({this.appBar, this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: [
        DropdownButton(
          items: [
            DropdownMenuItem(
              child: Container(
                child: Row(
                  children: [Text('Logout')],
                ),
              ),
              value: 'logout',
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
