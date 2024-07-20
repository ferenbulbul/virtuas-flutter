import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/clinic/possible_customers.dart';
import 'package:flutter_application_1/pages/clinic/sent_offers.dart'; // Import your actual screens

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
    // Extract arguments passed from Navigator
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Retrieve clinicId from arguments
    final int clinicId = args['clinicId'];

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
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PossibleClientPreDataScreen(clinicId: clinicId), // Replace with your actual screen/widget
          Center(child: Text('Services Page')), // Replace with your actual screen/widget
          SentOffersPage(clinicId: clinicId), // Replace with your actual screen/widget
          Center(child: Text('Clinic Info Page')), // Replace with your actual screen/widget
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
