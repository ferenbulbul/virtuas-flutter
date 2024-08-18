import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/admin/admin_landing.dart';
import 'package:flutter_application_1/pages/client/client_landing.dart';
import 'package:flutter_application_1/pages/client/register.dart';
import 'package:flutter_application_1/pages/clinic/clinic_landing.dart';
import 'package:flutter_application_1/pages/clinic/possible_customers.dart';
import 'package:flutter_application_1/pages/common/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WelcomePage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<String> isLoggedIn() async {
    String? loggedInRole = await storage.read(key: 'loggedInAs');
    if (loggedInRole == "admin") {
      return "admin";
    }
    if (loggedInRole == "clinic") {
      return "clinic";
    }
    if (loggedInRole == "client") {
      return "client";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String? loggedInRole = snapshot.data;
          if (loggedInRole == "admin") {
            return AdminPage(text: "Admin");
          }
          if (loggedInRole == "clinic") {
            return ClinicLandingPage();
          }
          if (loggedInRole == "client") {
            return ClientLandingPage();
          }
          else{
            return LoginPage();
          }
        }
      },
    );
  }
}
