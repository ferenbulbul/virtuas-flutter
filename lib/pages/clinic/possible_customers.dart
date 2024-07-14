import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/pages/clinic/possible_customer_detail.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/privacy.dart';

class PossibleClientPreDataScreen extends StatefulWidget {
  @override
  _PossibleClientPreDataScreenState createState() =>
      _PossibleClientPreDataScreenState();
}

class _PossibleClientPreDataScreenState
    extends State<PossibleClientPreDataScreen> {
  late Future<PossibleClientPreDataResponse> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchApplicationsPreData(36);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Possible Client PreData'),
      ),
      body: FutureBuilder<PossibleClientPreDataResponse>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.preDataList.length,
              itemBuilder: (context, index) {
                final item = snapshot.data!.preDataList[index];
                return ExpansionTile(
                  title: Text(
                      '${PrivacyUtils.maskName(item.userName)} ${PrivacyUtils.maskName(item.userSurname)}'),
                  subtitle: Text('${item.categoryTitle}'),
                  trailing: ElevatedButton(
                    child: Text('teklif Ver'),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PossibleClientPreDataDetailPage(
                            preData: item,
                          ),
                        ),
                      )
                    },
                  ),
                  children: item.answers.map((answer) {
                    return ListTile(
                      title: Text('Q: ${answer.question}'),
                      subtitle: Text('A: ${answer.answer}'),
                    );
                  }).toList(),

                  // todo:date gelsinn
                );
              },
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
