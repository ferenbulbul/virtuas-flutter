import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/common/login.dart';

class ClinicLandingPage extends StatefulWidget {
  @override
  _ClinicLandingPageState createState() => _ClinicLandingPageState();
}

class _ClinicLandingPageState extends State<ClinicLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Landing Page'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Vituras',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Possible customers'),
              onTap: () {
                // Update the state or navigate to a different screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Services'),
              onTap: () {
                // Update the state or navigate to a different screen
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Sent Offers'),
              onTap: () {
                // Update the state or navigate to a different screen
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Clinic Info '),
              onTap: () {
                // Update the state or navigate to a different screen
              },
            ),
          ],
        ),
      ),
      body: Center(child: LoginPage()),
    );
  }
}
