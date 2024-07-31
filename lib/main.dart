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
    const int _customPrimaryValue = 0xFFf0f4ff;

// Define a MaterialColor from the custom color
const MaterialColor customMaterialColor = MaterialColor(
  _customPrimaryValue,
  <int, Color>{
    50: Color(0xFFf3e5f5),
    100: Color(0xFFe1bee7),
    200: Color(0xFFce93d8),
    300: Color(0xFFba68c8),
    400: Color(0xFFab47bc),
    500: Color(_customPrimaryValue),
    600: Color(0xFF9c27b0),
    700: Color(0xFF8e24aa),
    800: Color(0xFF7b1fa2),
    900: Color(0xFF6a1b9a),
  },
);
    return SafeArea(
      child: MaterialApp(
        title: 'Vituras Health',
        theme: ThemeData(
          primarySwatch: customMaterialColor,                      
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
      ),
    );
  }
}


