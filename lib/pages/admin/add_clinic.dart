import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddClinicPage extends StatefulWidget {
  @override
  _AddClinicPageState createState() => _AddClinicPageState();
}

class _AddClinicPageState extends State<AddClinicPage> {
  final DataService _dataService = DataService();
  List<Category> categories = [];
  List<Category> selectedCategories = [];
  List<int> selectedCategoryIds = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _webAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataOnLoad();
  }

  void fetchDataOnLoad() async {
    List<Category> fetchedData = await _dataService.fetchCategories();
    setState(() {
      categories = fetchedData;
    });
  }

  List<Category> myCategories = [];

  Future<void> _login() async {
    String clinicAddUrl = 'https://localhost:7128/api/clinics/add';

    var postData = jsonEncode({
      'title': _titleController.text,
      'description': _descriptionController.text,
      "address": _addressController.text,
      "webaddress": _webAddressController.text,
      "categories": selectedCategoryIds
    });

    // POST isteği yapılıyor
    var response = await http.post(
      Uri.parse(clinicAddUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: postData,
    );

    // if (response.statusCode == 200) {
    //   _showSuccessDialog(context);
    // } else {
    //   // Hata durumunda hata mesajını yazdırıyoruz
    //   print('Failed to make POST request.');
    // }

    // POST isteği yapılıyor

    // Başarılı giriş durumunda bir sonraki sayfaya yönlendirme (Navigator)
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Clinic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _webAddressController,
              decoration: InputDecoration(labelText: 'Web Address'),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<Category>(
              isExpanded: true,
              hint: Text('Select Categories'),
              value: null,
              items: categories.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.title),
                );
              }).toList(),
              onChanged: (Category? selectedCategory) {
                if (selectedCategory != null &&
                    !selectedCategories.contains(selectedCategory) &&
                    !selectedCategoryIds.contains(selectedCategory.id)) {
                  setState(() {
                    selectedCategories.add(selectedCategory);
                    selectedCategoryIds.add(selectedCategory.id);
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedCategories.map((Category category) {
                return Chip(
                  label: Text(category.title),
                  onDeleted: () {
                    setState(() {
                      selectedCategories.remove(category);
                      selectedCategoryIds.remove(category.id);
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _login();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Clinic Added Successfully!')),
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.of(context).pushReplacementNamed('/admin');
                });
              },
              child: Text('Add Clinic'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Kullanıcının popup'ı kapatmasını engelle
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Item successfully deleted!'),
      );
    },
  );

  // 2 saniye sonra yönlendirme yap
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop(); // Başarı dialogunu kapat
    Navigator.pushNamed(context, '/AdminPage'); //  Yeni sayfaya yönlendir
  });
}

void _showInformation(BuildContext context) {
  Fluttertoast.showToast(
    msg: "Klinik başarıyla eklendi",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3, // iOS ve web için saniye cinsinden gösterim süresi
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 30.0,
  );
}
