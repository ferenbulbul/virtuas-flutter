import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/pages/admin/clinic_first_save.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddClinicPage extends StatefulWidget {
  const AddClinicPage({super.key});

  @override
  _AddClinicPageState createState() => _AddClinicPageState();
}

class _AddClinicPageState extends State<AddClinicPage> {
  final DataService _dataService = DataService();
  List<Category> categories = [];
  List<Category> selectedCategories = [];
  List<int> selectedCategoryIds = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _webAddressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

  Future<void> _addClinic() async {
    String clinicAddUrl = 'http://10.0.2.2:5241/api/clinics/add';
    var jsonData;
    var postData = jsonEncode({
      'title': _titleController.text,
      'description': _descriptionController.text,
      "address": _addressController.text,
      "webaddress": _webAddressController.text,
      "email": _emailController.text,
      "categories": selectedCategoryIds
    });

    var response = await http.post(
      Uri.parse(clinicAddUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      String username = jsonData["username"];
      String password = jsonData["password"];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ClinicUserInfoPage(
                  username: username,
                  password: password,
                )),
      );
    } else {
      print('Failed to make POST request.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xfffeac5e), Color(0xff4bc0c8)],
                  stops: [0, 1],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        
        appBar: AppBar(
          title: const Text('Add Clinic',style: TextStyle(fontSize: 30, color: Colors.white),),centerTitle: true ,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            iconSize: 30,
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Expanded(                
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 40),                 
                  TextField(
                    controller: _titleController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _descriptionController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Description',                      
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,                        
                      ),
                    ),
                    minLines: 2,
                    maxLines: 2,
                    maxLength: 200,
                    
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _addressController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    minLines: 2,
                    maxLines: 2,
                    maxLength: 200,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _webAddressController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Web Address',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _emailController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Email for the clinic contact',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<Category>(
                    isExpanded: true,
                    hint: const Text('Select Categories'),
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
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 20),
                  
                  ElevatedButton(
                    onPressed: _addClinic,
                    child: const Text('Add Clinic'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
