import 'package:flutter/material.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({super.key});

  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle form submission here
              String phoneNumber = _phoneNumberController.text;
              print('Phone number: $phoneNumber');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
