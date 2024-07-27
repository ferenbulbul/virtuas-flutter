import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_application_1/pages/admin/admin_landing.dart';
import 'package:flutter_application_1/pages/client/client_landing.dart';
import 'package:flutter_application_1/pages/client/register.dart';
import 'package:flutter_application_1/pages/clinic/clinic_landing.dart';
import 'package:flutter_application_1/pages/common/login.dart';
import 'package:flutter_application_1/pages/common/welcome.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      routes: {
        '/admin': (context) => const AdminPage(
              text: "",
            ),
        '/register': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/clientLandingPage': (context) => const ClientLandingPage(),
        '/clinicLandingPage': (context) {
          return const ClinicLandingPage();
        },
      },
    );
  }
}
