import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String apiUrl = 'http://10.0.2.2:5241/api/Auth/Login';
    var postData = jsonEncode({'username': username, 'password': password});

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: postData,
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);        
        var role = jsonData["role"];
        var clinicId = jsonData["clinicId"];
        var userId = jsonData["id"];
     
        if (role == 'admin') {
           await storage.write(key: 'loggedInAs', value: "admin");
          Navigator.pushReplacementNamed(context, '/admin');          
        } 
        else if (role == 'client') {
          await storage.write(key: 'loggedInAs', value: "client");
          await prefs.setInt("userId", userId);      
          Navigator.pushReplacementNamed(context, '/clientLandingPage');
        } 
        else if (role == 'clinic') {
           await storage.write(key: 'loggedInAs', value: "clinic");
           await prefs.setInt("clinicId", clinicId);      
          Navigator.pushReplacementNamed(context, '/clinicLandingPage', arguments: {
            'clinicId': clinicId,
          });
        }
        
      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              _login();
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
