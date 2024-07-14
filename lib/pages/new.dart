import 'package:flutter/material.dart';

class PhoneNumberForm extends StatefulWidget {
  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle form submission here
              String phoneNumber = _phoneNumberController.text;
              print('Phone number: $phoneNumber');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
