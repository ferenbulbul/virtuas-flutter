import 'package:flutter_application_1/models/application.dart';

class ApplicationDetailsResponse {
  List<Application>? applicationDetails;

  ApplicationDetailsResponse({this.applicationDetails});

  factory ApplicationDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationDetailsResponse(
      applicationDetails: (json['applicationDetails'] as List)
          .map((application) => Application.fromJson(application))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applicationDetails': applicationDetails
          ?.map((application) => application.toJson())
          .toList(),
    };
  }
}
