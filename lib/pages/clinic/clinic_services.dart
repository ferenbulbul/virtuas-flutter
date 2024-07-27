import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/services/dataService.dart';

class ClinicServicesPage extends StatefulWidget {
  @override
  _ClinicServicesPageState createState() => _ClinicServicesPageState();
}

class _ClinicServicesPageState extends State<ClinicServicesPage> {
  final DataService _dataService = DataService();
  List<Category> categories = [];
  List<Category> existingCategories = [];
  List<Category> selectedCategories = [];
  List<int> selectedCategoryIds = [];
  bool _isChanged = false;
  @override
  void initState() {
    super.initState();
    fetchDataOnLoad();
  }

  void fetchDataOnLoad() async {
    List<Category> fetchedData = await _dataService.fetchCategories();
    List<Category> _existingCategories =
        await _dataService.fetchSelectedCategories();
    setState(() {
      categories = fetchedData;
      existingCategories = _existingCategories;
      selectedCategories.addAll(existingCategories);
      selectedCategoryIds =
          existingCategories.map((category) => category.id).toList();
    });
  }

  bool isChanged() {
    Set<int> existingCategoryIds =
        Set.from(existingCategories.map((category) => category.id));
    Set<int> selectedCategoryIds =
        Set.from(selectedCategories.map((category) => category.id));

    bool areListsEqual =
        existingCategoryIds.difference(selectedCategoryIds).isEmpty &&
            selectedCategoryIds.difference(existingCategoryIds).isEmpty;
    return !areListsEqual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                  _isChanged = isChanged();
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
                    _isChanged = isChanged();
                  });
                },
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: _isChanged ? () => updateCategories(context) : null,
              child: Text("Kaydet"))
        ],
      ),
    ));
  }

  Future<void> updateCategories(BuildContext context) async {
    await showConfirmationDialog(
      context,
      () async {
        await _dataService.updateClinicCategoires(selectedCategoryIds);
      },
    );
  }

  Future<void> showConfirmationDialog(
      BuildContext context, Future<void> Function() onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Onay'),
          content: Text('Emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () async {
                Navigator.of(context).pop();
                await onConfirm();
                showSuccessAlert();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessAlert() {
    Fluttertoast.showToast(
      msg: "Başarıyla güncellendi",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}
