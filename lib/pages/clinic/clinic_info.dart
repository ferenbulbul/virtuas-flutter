import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/services/dataService.dart';
import 'package:flutter_application_1/utils/color_select.dart';

class ClinicInfoPage extends StatefulWidget {
  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicInfoPage> {
  late Future<Clinic> futureClinic;

  @override
  void initState() {
    super.initState();
    futureClinic = fetchClinic();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );
    const textStyleNormal = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );

    const textStyleBold = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    const textStyleRed =
        TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.red);

    return SafeArea(
      child: FutureBuilder<Clinic>(
        future: futureClinic,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final clinic = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      clinic.title,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Has the best services!",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
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
                              Icons.person_2_sharp,
                              size: 25.0,
                              color: ColorSelect.background,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Clinic Description:',
                              style: textStyleBold),
                          Text(clinic.description, style: textStyleNormal),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                              Icons.map_sharp,
                              size: 25.0,
                              color: ColorSelect.background,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address:', style: textStyleBold),
                          Text(clinic.address, style: textStyleNormal),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                              Icons.web_asset,
                              size: 25.0,
                              color: ColorSelect.background,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Website:', style: textStyleBold),
                          Text(clinic.webAddress, style: textStyleNormal),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                              Icons.email_sharp,
                              size: 25.0,
                              color: ColorSelect.background,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email:', style: textStyleBold),
                          Text(clinic.eMail, style: textStyleNormal),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          const Text('Current Credit:', style: textStyleBold),
                          Text(clinic.credit.toString(),
                              style: clinic.credit < 50
                                  ? textStyleRed
                                  : textStyleNormal),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
