import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/pages/admin/clinic_details.dart';
import 'package:flutter_application_1/services/dataService.dart';
// fetchClinics fonksiyonunu buraya import edin

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  _ClinicsPageState createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  late Future<List<Clinic>> futureClinics;

  @override
  void initState() {
    super.initState();
    futureClinics = fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xfffeac5e), Color(0xff4bc0c8)],
                  stops: [0, 1],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Clinics',style: TextStyle(fontSize: 30, color: Colors.white),),centerTitle: true ,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            iconSize: 30,
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Clinic>>(
            future: futureClinics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClinicDetailPage(clinic: snapshot.data![index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(snapshot.data![index].description),
                                const SizedBox(height: 8),
                                Text(snapshot.data![index].credit.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
      
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
