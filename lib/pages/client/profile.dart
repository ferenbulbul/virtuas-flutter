import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/pages/client/change_password.dart';
import 'package:flutter_application_1/services/dataService.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> futureUser;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isChanged = false;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(widget.userId);
    futureUser.then((user) {
      emailController.text = user.email;
      nameController.text = user.name;
      surnameController.text = user.surname;
      phoneController.text = user.phoneNumber;

      
      phoneController.addListener(_setChanged);
    });
  }

  void _setChanged() {
    setState(() {
      _isChanged = true;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildProfileForm(snapshot.data!);
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildProfileForm(User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              readOnly: true,
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              readOnly: true,
              controller: surnameController,
              decoration: const InputDecoration(labelText: 'Surname'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your surname';
                }
                return null;
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isChanged
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        User updatedUser = User(
                          id: widget.userId,
                          email: emailController.text,
                          name: nameController.text,
                          surname: surnameController.text,
                          phoneNumber: phoneController.text,
                        );
                        updateUser(updatedUser).then((updatedUser) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile updated successfully')),
                          );
                          setState(() {
                            _isChanged = false;
                          });
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Failed to update profile')),
                          );
                        });
                      }
                    }
                  : null,
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
  builder: (context) => ChangePasswordPage(),
));
              },
              child: const Text('Change Password'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                logout;
              },
              child: const Text('Logout'),
            ),

          ],
        ),
      ),
    );
  }
}
