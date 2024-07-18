import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/applications_detail.dart';
import 'package:flutter_application_1/pages/client/application_detail.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationsPage extends StatefulWidget {
  @override
  _ApplicationsPageState createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  Future<ApplicationDetailsResponse>? futureApplications;

  int? userId;
  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  void _loadUserId() async {
    // Burada userId'i yükle
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ??
        0; // Örneğin, userId yükleme işlemi async olarak gerçekleştiriliyor

    // userId yüklendikten sonra setState ile futureApplications'ı güncelle
    setState(() {
      futureApplications = fetchApplications(userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
      ),
      body: FutureBuilder<ApplicationDetailsResponse>(
        future: futureApplications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.applicationDetails?.length ?? 0,
              itemBuilder: (context, index) {
                var application = snapshot.data!.applicationDetails![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicationDetailPage(
                            application: application,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              application.categoryTitle ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Category Description: ${application.categoryDescription}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Application Date: ${application.applicationDate}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
