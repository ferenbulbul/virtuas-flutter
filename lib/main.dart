import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_application_1/pages/admin/admin_landing.dart';
import 'package:flutter_application_1/pages/category/add_category.dart';
import 'package:flutter_application_1/pages/client/client_landing.dart';
import 'package:flutter_application_1/pages/client/register.dart';
import 'package:flutter_application_1/pages/clinic/clinic_landing.dart';
import 'package:flutter_application_1/pages/clinic/possible_customers.dart';
import 'package:flutter_application_1/pages/common/login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Başlangıç sayfası
      routes: {
        '/admin': (context) => AdminPage(
              text: "",
            ),
        '/register': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
        '/clientlandingpage': (context) => ClientLandingPage(),
        '/cliniclandingpage': (context) => ClinicLandingPage(),

        // Diğer rotaları buraya ekleyebilirsiniz
      },
    );
  }
}
