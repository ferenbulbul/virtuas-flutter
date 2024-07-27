import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/services/dataService.dart';



class ClinicInfoPage extends StatefulWidget {
  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicInfoPage> {
  late Future<Clinic> futureClinic;

  @override
  void initState() {
    super.initState();
    futureClinic = fetchClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: FutureBuilder<Clinic>(
        future: futureClinic,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final clinic = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${clinic.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Description: ${clinic.description}'),
                  SizedBox(height: 8),
                  Text('Address: ${clinic.address}'),
                  SizedBox(height: 8),
                  Text('Website: ${clinic.webAddress}'),
                  SizedBox(height: 8),
                  Text('Credit: ${clinic.credit}'),
                  SizedBox(height: 8),
                  Text('Email: ${clinic.eMail}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
