import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'dart:async';

class AddCreditPage extends StatefulWidget {
  final Clinic clinic;

  const AddCreditPage({super.key, required this.clinic});

  @override
  _AddCreditPageState createState() => _AddCreditPageState();
}

class _AddCreditPageState extends State<AddCreditPage> {
  final TextEditingController _creditController = TextEditingController();

  void _addCredit() {
    int? newCredit = int.tryParse(_creditController.text);
    if (newCredit != null) {
      setState(() {
        widget.clinic.credit += newCredit;
      });
      addCreditToclinic(widget.clinic.id, widget.clinic.credit);
      // Kredi ekleme işlemi tamamlandıktan sonra veritabanına kaydetme işlemini yapabilirsiniz
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credit added successfully!')),
      );
      _creditController.clear(); // Giriş alanını temizle
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed('/admin');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credit amount!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Credit to Clinic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinic Name: ${widget.clinic.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Existing Credit: ${widget.clinic.credit}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _creditController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                labelText: 'Enter Credit To Add / Remove',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCredit,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
