import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/pages/admin/clinic_add_credit.dart';
import 'package:flutter_application_1/services/dataService.dart';

class ClinicDetailPage extends StatefulWidget {
  final Clinic clinic;

  const ClinicDetailPage({super.key, required this.clinic});

  @override
  _ClinicDetailPageState createState() => _ClinicDetailPageState();
}

class _ClinicDetailPageState extends State<ClinicDetailPage> {
  final DataService _dataService = DataService();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  late TextEditingController webAddressController;
  List<Category> selectedCategoires = [];
  List<Category> allCategories = [];

  bool isUpdated = false;

  @override
  void initState() {
    super.initState();
    getSelectedClinics();
    getAllClinicsOnLoad();
    titleController = TextEditingController(text: widget.clinic.title);
    descriptionController =
        TextEditingController(text: widget.clinic.description);
    addressController = TextEditingController(text: widget.clinic.address);
    webAddressController =
        TextEditingController(text: widget.clinic.webAddress);

    titleController.addListener(_checkIfUpdated);
    descriptionController.addListener(_checkIfUpdated);
    addressController.addListener(_checkIfUpdated);
    webAddressController.addListener(_checkIfUpdated);
  }

  void getAllClinicsOnLoad() async {
    List<Category> fetchedData = await _dataService.fetchCategories();
    setState(() {
      allCategories = fetchedData;
    });
  }

  void getSelectedClinics() async {
    List<Category> fetchedData =
        await _dataService.fetchSelectedCategories(widget.clinic.id);
    setState(() {
      selectedCategoires = fetchedData;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    webAddressController.dispose();
    super.dispose();
  }

  void _checkIfUpdated() {
    setState(() {
      isUpdated = titleController.text != widget.clinic.title ||
          descriptionController.text != widget.clinic.description ||
          addressController.text != widget.clinic.address ||
          webAddressController.text != widget.clinic.webAddress;
    });
  }

  void saveClinic() {
    editClinic(Clinic(
        id: widget.clinic.id,
        title: titleController.text,
        description: descriptionController.text,
        address: addressController.text,
        webAddress: webAddressController.text,
        credit: 0));
  }

  void _deleteClinic() {
    deleteClinic(widget.clinic.id);
  }

  void goToAddCredit() {}

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('bu kliniği silmek isteğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteClinic();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clinic deleted successfully!')),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pushReplacementNamed('/admin');
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: isUpdated
                ? () {
                    saveClinic();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Clinic updated successfully!')),
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pushReplacementNamed('/admin');
                    });
                  }
                : null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: webAddressController,
              decoration: const InputDecoration(labelText: 'Web Address'),
            ),
            const SizedBox(height: 20),
            Text(
              widget.clinic.credit.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // DropdownButtonFormField<Category>(
            //   isExpanded: true,
            //   hint: Text('Select Categories'),
            //   value: null,
            //   items: allCategories.map((Category category) {
            //     return DropdownMenuItem<Category>(
            //       value: category,
            //       child: Text(category.title),
            //     );
            //   }).toList(),
            //   onChanged: (Category? selectedCategory) {
            //     if (selectedCategory != null &&
            //         !selectedCategoires.contains(selectedCategory)) {
            //       setState(() {
            //         selectedCategoires.add(selectedCategory);
            //         // selectedCategoryIds.add(selectedCategory.id);
            //       });
            //     }
            //   },
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     filled: true,
            //     fillColor: Colors.grey.shade200,
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            // Wrap(
            //   spacing: 8.0,
            //   runSpacing: 8.0,
            //   children: selectedCategoires.map((Category category) {
            //     return Chip(
            //       label: Text(category.title),
            //       onDeleted: () {
            //         setState(() {
            //           selectedCategoires.remove(category);
            //           selectedCategoires.remove(category.id);
            //         });
            //       },
            //     );
            //   }).toList(),
            // ),
            ElevatedButton(
              onPressed: () => _showDeleteConfirmationDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCreditPage(clinic: widget.clinic),
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Add Token'),
            )
          ],
        ),
      ),
    );
  }
}
