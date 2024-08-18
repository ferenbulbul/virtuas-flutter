import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/pages/clinic/possible_customer_detail.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/color_select.dart';
import 'package:flutter_application_1/utils/privacy.dart';

class PossibleClientPreDataScreen extends StatefulWidget {
  const PossibleClientPreDataScreen({super.key});

  @override
  _PossibleClientPreDataScreenState createState() =>
      _PossibleClientPreDataScreenState();
}

class _PossibleClientPreDataScreenState
    extends State<PossibleClientPreDataScreen> with RouteAware {
  late Future<PossibleClientPreDataResponse> futureData;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureData = fetchApplicationsPreData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PossibleClientPreDataResponse>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Hello!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Have a nice day!",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 50.0),
                      Text("Check these out!",
                          style: TextStyle(
                              fontSize: 25,
                              color: ColorSelect.secondary,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = snapshot.data!.preDataList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorSelect.secondary,
                          border: Border.all(
                            color: ColorSelect.primary,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            '${PrivacyUtils.maskName(item.userName)} ${PrivacyUtils.maskName(item.userSurname)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(item.categoryTitle, style: const TextStyle(color: Colors.white)),
                          trailing: ElevatedButton(
                            child: Text("Give Offer: ${item.cost} Token"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PossibleClientPreDataDetailPage(
                                    preData: item,
                                  ),
                                ),
                              );
                            },
                          ),
                          children: item.answers.map((answer) {
                            return ListTile(
                              title: Text('Q: ${answer.question}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              subtitle: Text('A: ${answer.answer}', style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  childCount: snapshot.data!.preDataList.length,
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
