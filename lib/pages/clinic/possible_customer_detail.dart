import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/utils/privacy.dart';

class PossibleClientPreDataDetailPage extends StatelessWidget {
  final PossibleClientPreData preData;

  const PossibleClientPreDataDetailPage({super.key, required this.preData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Possible Client Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${PrivacyUtils.maskName(preData.userName)} ${PrivacyUtils.maskName(preData.userSurname)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${preData.categoryTitle}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Questions and Answers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: preData.answers.length,
                itemBuilder: (context, index) {
                  final answer = preData.answers[index];
                  return ListTile(
                    title: Text('Q: ${answer.question}'),
                    subtitle: Text('A: ${answer.answer}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
                style:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
                'Teklif verdiğiniz takdirde müşterinin tüm detayları sizinle paylaşılacaktır.'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle "Teklif Ver" button press
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Teklif Ver pressed')),
                  );
                },
                child: const Text('Teklif Ver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
