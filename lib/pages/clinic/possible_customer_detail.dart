import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/color_select.dart';
import 'package:flutter_application_1/utils/privacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PossibleClientPreDataDetailPage extends StatefulWidget {
  final PossibleClientPreData preData;

  const PossibleClientPreDataDetailPage({Key? key, required this.preData})
      : super(key: key);

  @override
  State<PossibleClientPreDataDetailPage> createState() =>
      _PossibleClientPreDataDetailPageState();
}

class _PossibleClientPreDataDetailPageState
    extends State<PossibleClientPreDataDetailPage> {
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
    bool canGiveOffer =
        clinicCredit != null && clinicCredit! > widget.preData.cost;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Last Step...",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "You have $clinicCredit credits",
                      style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 50.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: ColorSelect.secondary,
                              padding: const EdgeInsets.all(10.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.money_sharp,
                                size: 25.0,
                                color: ColorSelect.background,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Client Data',
                            ),
                            Text(
                              '${PrivacyUtils.maskName(widget.preData.userName)} ${PrivacyUtils.maskName(widget.preData.userSurname)}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: ColorSelect.secondary,
                              padding: const EdgeInsets.all(10.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.money_sharp,
                                size: 25.0,
                                color: ColorSelect.background,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category',
                            ),
                            Text(
                              widget.preData.categoryTitle,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.preData.answers.map((answer) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () {},
                                      fillColor: ColorSelect.secondary,
                                      padding: const EdgeInsets.all(10.0),
                                      shape: const CircleBorder(),
                                      child: const Icon(
                                        Icons.question_mark_sharp,
                                        size: 25.0,
                                        color: ColorSelect.background,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Q: ${answer.question}'),
                                    const SizedBox(height: 4),
                                    Text(
                                      'A: ${answer.answer}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                   
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius:
                            BorderRadius.circular(8.0), 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), 
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(
                          16.0), // Padding inside the container
                      child: const Text(
                        'Teklif verdiğiniz takdirde müşterinin tüm detayları sizinle paylaşılacaktır.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color:ColorSelect.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton.icon(
                      onPressed: canGiveOffer
                          ? () => _giveOffer(clinicId,
                              widget.preData.applicationId, widget.preData.cost)
                          : null,
                      icon: const Icon(Icons.local_offer_sharp, size: 30),
                      label: Text(canGiveOffer
                          ? "Teklif ver: ${widget.preData.cost.toString()} Token"
                          : "Credit is insufficient", style: const TextStyle(fontSize: 20),),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey; // Color when button is disabled
                          }
                          return ColorSelect
                              .secondary; // Color when button is enabled
                        }),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0)),
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
      var result = giveOffer(clinicId, applicationId, price);

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
