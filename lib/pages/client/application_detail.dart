import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/application.dart';
import 'package:intl/intl.dart';

class ApplicationDetailPage extends StatelessWidget {
  final Application application;

  const ApplicationDetailPage({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Application Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formatter.format(application.applicationDate!),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${application.categoryTitle}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${application.categoryDescription}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Answers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: application.answers!.map((answer) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${answer.questionTitle}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        answer.answerTitle ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: application.offeredClinics != null && application.offeredClinics!.isNotEmpty ? application.offeredClinics!.map((answer) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${answer}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),                    
                    ],
                  ),
                );
              }).toList() :
              [  // Return a list containing a single Text widget if no clinics are offered
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "No offered clinics available",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
            ),

          ],
        ),
      ),
    );
  }
}
