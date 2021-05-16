import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../screens/dashboard_screen.dart';
import '../../providers/profile_provider.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String _userName = '';
  int _age;
  String _profession = '';
  String _location = '';
  final _formKey = GlobalKey<FormState>();

  static const initialCountry = 'NP';
  PhoneNumber number = PhoneNumber(isoCode: initialCountry);

  void _submitForm(BuildContext context) {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
    } else {
      return;
    }
    Provider.of<Profile>(context, listen: false).sendProfile(
        _userName, _age, _profession, _location, number.toString());
    Navigator.of(context).pushNamed(DashboardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Card(
              elevation: 100,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Username can't be empty";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'UserName',
                        ),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('age'),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "age can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Age'),
                        onSaved: (value) {
                          _age = int.parse(value);
                        },
                      ),
                      TextFormField(
                        key: ValueKey('profession'),
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Profession can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Profession'),
                        onSaved: (value) {
                          _profession = value;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('location'),
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Location can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Location'),
                        onSaved: (value) {
                          _location = value;
                        },
                      ),
                      InternationalPhoneNumberInput(
                        initialValue: number,
                        onInputChanged: (_) {},
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        maxLength: 10,
                        formatInput: false,
                        onSaved: (value) {
                          number = value;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Phone number cant be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => _submitForm(context), child: Text('Submit')),
            ElevatedButton(
              onPressed: () =>
                  Provider.of<Profile>(context, listen: false).printToken(),
              child: Text('token'),
            )
          ],
        ),
      ),
    );
  }
}
