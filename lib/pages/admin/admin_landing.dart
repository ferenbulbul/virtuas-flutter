import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/admin/add_clinic.dart';
import 'package:flutter_application_1/pages/admin/list_clinics.dart';
import 'package:flutter_application_1/pages/category/add_category.dart';
import 'package:flutter_application_1/pages/category/list_category.dart';
import 'package:flutter_application_1/services/dataService.dart';

class AdminPage extends StatelessWidget {
  final String text;

  const AdminPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  // Button 1 pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddClinicPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.blue,
                child: const Text(
                  'Clinc Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  // Button 2 pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ClinicsPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.green,
                child: const Text(
                  'List Clinics',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddCategoryPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.orange,
                child: const Text(
                  'Category Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoryListPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.amber,
                child: const Text(
                  'List Categories',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: logout, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
