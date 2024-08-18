import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/utils/color_select.dart';
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
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Your services",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "You can easiliy manage your service categories!",
            style: TextStyle(
                fontSize: 20, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(
            height: 50,
          ),
          DropdownButtonFormField<Category>(
            isExpanded: true,
            dropdownColor: ColorSelect.secondary,
            hint: const Text(
              'Select Categories',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            value: null,
            items: categories.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(
                  category.title,
                  style: const TextStyle(color: Colors.white),
                ),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  borderSide: const BorderSide(
                    color: Colors
                        .transparent, // Change the color of the border when enabled
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  borderSide: const BorderSide(
                    color: Colors
                        .transparent, // Change the color of the border when focused
                  ),
                ),
                filled: true,
                fillColor:
                    ColorSelect.secondary, // Replace with ColorSelect.secondary
                labelStyle: TextStyle(color: Colors.white)
                // Hint text color
                // Text color
                ),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: selectedCategories.map((Category category) {
              return Chip(
                label: Text(
                  category.title,
                  style: const TextStyle(color: ColorSelect.secondary),
                ),
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
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _isChanged ? () => updateCategories(context) : null,
            icon: const Icon(Icons.save, size: 24),
            label: const Text('Save Changes'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey; // Color when button is disabled
                }
                return ColorSelect.secondary; // Color when button is enabled
              }),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          )
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
