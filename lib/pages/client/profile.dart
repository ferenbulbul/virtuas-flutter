import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/dataService.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  ProfilePage({required this.userId});

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

      emailController.addListener(_setChanged);
      nameController.addListener(_setChanged);
      surnameController.addListener(_setChanged);
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
        title: Text('Profile'),
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildProfileForm(snapshot.data!);
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildProfileForm(User user) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Surname'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your surname';
                }
                return null;
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
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
                            SnackBar(
                                content: Text('Profile updated successfully')),
                          );
                          setState(() {
                            _isChanged = false;
                          });
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to update profile')),
                          );
                        });
                      }
                    }
                  : null,
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SetPasswordPage(userId: widget.userId),
                //   ),
                // );
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
