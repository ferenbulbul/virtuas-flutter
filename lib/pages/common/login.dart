import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const/roles.dart';
import 'package:flutter_application_1/pages/admin/admin_landing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    var jsonData;
    String apiUrl = 'http://10.0.2.2:5241/api/Auth/Login';    
    
    var postData = jsonEncode({'username': username, 'password': password});
    // POST isteği yapılıyor
    var response = await http.post(


      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      // Başarılı cevap durumunda JSON verisini alıyoruz
      jsonData = jsonDecode(response.body);
      var role = jsonData["role"];
      var username = jsonData["username"];
      var id = jsonData["id"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', id); // Kullanıcı ID'sini depoluyoruz

      if (role == Roles.Admin) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage(text: username)),
        );
      }
      if (role == Roles.Client) {
        Navigator.of(context).pushReplacementNamed('/clientlandingpage');
      }
      if (role == Roles.Clinic) {
        Navigator.of(context).pushReplacementNamed('/cliniclandingpage');
      }
    } else {
      // Hata durumunda hata mesajını yazdırıyoruz
      print('Failed to make POST request.');
    }

    // Başarılı giriş durumunda bir sonraki sayfaya yönlendirme (Navigator)
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
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
