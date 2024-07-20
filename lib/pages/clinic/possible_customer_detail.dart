import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/pages/clinic/possible_customers.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/privacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PossibleClientPreDataDetailPage extends StatefulWidget {
  final PossibleClientPreData preData;

  const PossibleClientPreDataDetailPage({Key? key, required this.preData}) : super(key: key);

  @override
  State<PossibleClientPreDataDetailPage> createState() => _PossibleClientPreDataDetailPageState();
}

class _PossibleClientPreDataDetailPageState extends State<PossibleClientPreDataDetailPage> {
  int? clinicId;
  int? clinicCredit;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadClinicInfo();
  }

  Future<void> _loadClinicInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      clinicId = prefs.getInt('clinicId') ?? 0;
    });

    int? credit = await getClinicCredit(clinicId!);
    setState(() {
      clinicCredit = credit ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool canGiveOffer = clinicCredit != null && clinicCredit! >= widget.preData.cost;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Credit: ${clinicCredit ?? 0}'),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${PrivacyUtils.maskName(widget.preData.userName)} ${PrivacyUtils.maskName(widget.preData.userSurname)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${widget.preData.categoryTitle}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Questions and Answers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.preData.answers.length,
                itemBuilder: (context, index) {
                  final answer = widget.preData.answers[index];
                  return ListTile(
                    title: Text('Q: ${answer.question}'),
                    subtitle: Text('A: ${answer.answer}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Teklif verdiğiniz takdirde müşterinin tüm detayları sizinle paylaşılacaktır.',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Center(
              child: ElevatedButton(
                onPressed: canGiveOffer ? () => _giveOffer(clinicId, widget.preData.applicationId,widget.preData.cost) : null,
                child: Text(canGiveOffer ? "Teklif ver: ${widget.preData.cost.toString()} Token" : "Credit is insufficient"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _giveOffer(int? clinicId, int applicationId, int price) async {
    setState(() {
      _isLoading = true; // Show progress indicator
    });

    // Simulated delay to mimic API call
    await Future.delayed(Duration(seconds: 2));

    try {
      var result = giveOffer(clinicId,applicationId,price);

      // Simulated credit deduction
      setState(() {
        clinicCredit = (clinicCredit ?? 0) - widget.preData.cost;
      });

      // Show modal dialog on offer success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Offer Given Successfully'),
            content: Text('Your offer has been successfully given.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                   Navigator.of(context).pop(); // Go back
                  // Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PossibleClientPreDataScreen(clinicId: clinicId!                                         
                  //         ),
                  //       ),
                  //     );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle API call errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error giving offer: $e'),
        duration: Duration(seconds: 2),
      ));
    } finally {
      setState(() {
        _isLoading = false; // Hide progress indicator
      });
    }
  }  
}
