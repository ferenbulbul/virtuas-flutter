import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/answer.dart';
import 'package:flutter_application_1/models/summary.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPage extends StatefulWidget {
  final SummaryData summaryData;

  const SummaryPage({super.key, required this.summaryData});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  int? userId;
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    });
  }

  Future<void> _getOffers() async {
    SummaryData data = widget.summaryData;
    int categoryId = data.category.id;
    Map<int, String> answers = data.answers;

    List<Answer> getAnswer = answers.entries.map((e) {
      return Answer(
          id: e.key, title: e.value, questionId: e.key); //la buna bakalım
    }).toList();

    // JSON formatına dönüştürme (sadece liste)
    List<Map<String, dynamic>> list =
        getAnswer.map((answer) => answer.toJson()).toList();
    String apiUrl =
        'http://10.0.2.2:5241/api/Application/Add?userId=$userId&categoryId=$categoryId';

    var postData = jsonEncode(list);
    //POST isteği yapılıyor
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered successfully!')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed('/clientLandingPage');
      });
    } else {
      // Hata durumunda hata mesajını yazdırıyoruz
      print('Failed to make POST request.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kategori Adı: ${widget.summaryData.category.title}'),
            const SizedBox(height: 8),
            Text('Açıklama: ${widget.summaryData.category.description}'),
            const SizedBox(height: 16),
            const Text(
              'Answers Summary:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.summaryData.answers.length,
                itemBuilder: (context, index) {
                  int questionId =
                      widget.summaryData.answers.keys.elementAt(index);
                  String questionTitle =
                      widget.summaryData.questions.elementAt(index).title;

                  String answer =
                      widget.summaryData.answers.values.elementAt(index);
                  return ListTile(
                    title: Text(questionTitle),
                    subtitle: Text(answer),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _getOffers(),
                child: Text('Get Best Offers $userId'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
