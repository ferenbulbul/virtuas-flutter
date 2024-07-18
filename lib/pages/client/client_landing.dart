import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/pages/category/category_detail.dart';
import 'package:flutter_application_1/pages/client/applications.dart';
import 'package:flutter_application_1/pages/client/profile.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientLandingPage extends StatefulWidget {
  const ClientLandingPage({super.key});

  @override
  _ClientLandingPageState createState() => _ClientLandingPageState();
}

class _ClientLandingPageState extends State<ClientLandingPage> {
  int? userId;
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    });
  }

  int _selectedIndex = 1; // Discover page is the default

  List<Category> categories = [];
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    fetchDataOnLoad();
    _loadUserId();
  }

  void fetchDataOnLoad() async {
    List<Category> fetchedData = await _dataService.fetchCategories();
    setState(() {
      categories = fetchedData;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildProfilePage() {
    if (userId == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ProfilePage(userId: userId!);
  }

  Widget _buildDiscoverPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<Category>(
            hint: const Text('Select a category'),
            value: null,
            onChanged: (Category? newValue) {
              if (newValue != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryDetailPage(category: newValue),
                  ),
                );
              }
            },
            items: categories.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.title),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildApplicationsPage() {
    return const ApplicationsPage();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      _buildProfilePage(),
      _buildDiscoverPage(),
      _buildApplicationsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Landing Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: 'Apply',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
    );
  }
}
