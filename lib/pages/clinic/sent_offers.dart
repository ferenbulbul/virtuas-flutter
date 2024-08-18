import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/client_data.dart';
import 'package:flutter_application_1/models/client_data_response.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/color_select.dart';

class SentOffersPage extends StatefulWidget {
  const SentOffersPage({Key? key}) : super(key: key);

  @override
  _SentOffersPageState createState() => _SentOffersPageState();
}

class _SentOffersPageState extends State<SentOffersPage> {
  late Future<ClientDataResponse> _clientDataResponseFuture;

  @override
  void initState() {
    super.initState();
    _clientDataResponseFuture = fetchMadeOffers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientDataResponse>(
      future: _clientDataResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.clientDataList!.isEmpty) {
          return const Center(child: Text('No offers made by the clinic.'));
        } else {
          return CustomScrollView(
            slivers: [
              // Header section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Very close!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Customers await!",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Make a quick call or send email!",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Customer Informations",
                        style: TextStyle(
                            fontSize: 25,
                            color: ColorSelect.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              // List section
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    ClientData clientData = snapshot.data!.clientDataList![index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorSelect.secondary,
                          border: Border.all(
                            color: ColorSelect.primary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'Customer: ${clientData.userName} ${clientData.userSurname}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          tilePadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
                          subtitle: Text(
                            clientData.offerDate.toString(),
                            style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                'Category: ${clientData.categoryTitle}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Cost: ${clientData.cost}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Offer Date: ${clientData.offerDate.toString()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'User Email: ${clientData.userEmail}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'User Phone: ${clientData.userPhone}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ExpansionTile(
                              title: const Text(
                                'Answers',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              children: clientData.answers!.map((answerAndQuestion) {
                                return ListTile(
                                  title: Text(
                                    'Q : ${answerAndQuestion.questionTitle}',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'A : ${answerAndQuestion.answerTitle}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: snapshot.data!.clientDataList!.length,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
