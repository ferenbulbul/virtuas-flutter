import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';


class ClinicUserInfoPage extends StatelessWidget {
  final String username;
  final String password;

  ClinicUserInfoPage({
    required this.username,
    required this.password,
  });

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((_) {      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinic User Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCopyRow('Username', username),
            SizedBox(height: 8.0),
            _buildCopyRow('Password', password),
            SizedBox(height: 16.0),
            Text(
              'Password will be forced to be changed at first login.',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyRow(String label, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label: $text'),
        IconButton(
          icon: Icon(Icons.copy),
          onPressed: () {
            _copyToClipboard(text);
          },
        ),
      ],
    );
  }
}
