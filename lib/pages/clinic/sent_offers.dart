import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/client_data.dart';
import 'package:flutter_application_1/models/client_data_response.dart';
import 'package:flutter_application_1/services/dataService.dart';

class SentOffersPage extends StatefulWidget {
  final int clinicId;

  SentOffersPage({Key? key, required this.clinicId}) : super(key: key);

  @override
  _SentOffersPageState createState() => _SentOffersPageState();
}

class _SentOffersPageState extends State<SentOffersPage> {
  late Future<ClientDataResponse> _clientDataResponseFuture;

  @override
  void initState() {
    super.initState();
    _clientDataResponseFuture = fetchMadeOffers(widget.clinicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers Made by Clinic'),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: FutureBuilder<ClientDataResponse>(
        future: _clientDataResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.clientDataList!.isEmpty) {
            return Center(child: Text('No offers made by the clinic.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.clientDataList!.length,
              itemBuilder: (context, index) {
                ClientData clientData = snapshot.data!.clientDataList![index];
                return ExpansionTile(
                  title: Text('Application ID: ${clientData.applicationId}'),
                  subtitle: Text('User: ${clientData.userName} ${clientData.userSurname}'),
                  children: [
                    ListTile(
                      title: Text('Category: ${clientData.categoryTitle}'),
                      subtitle: Text('Cost: ${clientData.cost}'),
                    ),
                    ListTile(
                      title: Text('Offer Date: ${clientData.offerDate.toString()}'),
                    ),
                    ListTile(
                      title: Text('User Email: ${clientData.userEmail}'),
                    ),
                    ListTile(
                      title: Text('User Phone: ${clientData.userPhone}'),
                    ),
                    ExpansionTile(
                      title: Text('Answers'),
                      children: clientData.answers!.map((answerAndQuestion) {
                        return ListTile(
                          title: Text('${answerAndQuestion.questionTitle}'),
                          subtitle: Text('${answerAndQuestion.answerTitle}'),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

