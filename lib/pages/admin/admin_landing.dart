import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/admin/add_clinic.dart';
import 'package:flutter_application_1/pages/admin/list_clinics.dart';
import 'package:flutter_application_1/pages/category/add_category.dart';
import 'package:flutter_application_1/pages/category/list_category.dart';

class AdminPage extends StatelessWidget {
  final String text;

  AdminPage({required this.text});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
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
                    MaterialPageRoute(builder: (context) => AddClinicPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.blue,
                child: Text(
                  'Clinc Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  // Button 2 pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClinicsPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.green,
                child: Text(
                  'List Clinics',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCategoryPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.orange,
                child: Text(
                  'Category Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonWidth,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryListPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 8),
                ),
                fillColor: Colors.amber,
                child: Text(
                  'List Categories',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
