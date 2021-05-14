import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 100,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('username'),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'UserName',
                    ),
                  ),
                  TextFormField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
