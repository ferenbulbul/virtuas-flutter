import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/clinic/clinic_info.dart';
import 'package:flutter_application_1/pages/clinic/clinic_services.dart';
import 'package:flutter_application_1/pages/clinic/possible_customers.dart';
import 'package:flutter_application_1/pages/clinic/sent_offers.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your actual screens

class ClinicLandingPage extends StatefulWidget {
  

  const ClinicLandingPage({Key? key,}) : super(key: key);

  @override
  _ClinicLandingPageState createState() => _ClinicLandingPageState();
}

class _ClinicLandingPageState extends State<ClinicLandingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 0; // Default to the Possible Customers tab   
  }
 


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Landing Page'),
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
            const SizedBox(
              height: 150.0,
              child: DrawerHeader(
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
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Possible customers'),
              onTap: () {
                _tabController.index = 0;
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Services'),
              onTap: () {
                _tabController.index = 1;
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Sent Offers'),
              onTap: () {
                _tabController.index = 2;
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Clinic Info'),
              onTap: () {
                _tabController.index = 3;
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            Divider(), // Optional: Add a divider before logout button
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {

                logout;
                // Implement logout logic here
                Navigator.of(context).pop(); // Close the drawer
                // Example: Navigate to login page

                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const PossibleClientPreDataScreen(), 
          ClinicServicesPage(),
          SentOffersPage(), 
          ClinicInfoPage()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
