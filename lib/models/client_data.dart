import 'package:flutter_application_1/models/answer_question.dart';

class ClientData {
  int? applicationId;
  String? userName;
  String? userSurname;
  String? userEmail;
  String? userPhone;
  DateTime? offerDate;
  String? categoryTitle;
  int? cost;
  List<AnswerAndQuestion>? answers;

  ClientData({
    required this.applicationId,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    required this.userPhone,
    required this.offerDate,
    required this.categoryTitle,
    required this.cost,
    required this.answers,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    
    return ClientData(
      applicationId: json['applicationId'],
      userName: json['userName'],
      userSurname: json['userSurname'],
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      offerDate: DateTime.parse(json['offerDate']), // Adjust parsing based on actual date format
      categoryTitle: json['categoryTitle'],
      cost: json['cost'],
      answers: (json['answers'] as List)
          .map((answer) => AnswerAndQuestion.fromJson(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // Convert answers list to JSON
    return {
      'applicationId': applicationId,
      'userName': userName,
      'userSurname': userSurname,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'offerDate': offerDate?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'categoryTitle': categoryTitle,
      'cost': cost,
      'answers': answers?.map((answer) => answer.toJson()).toList(),
    };
  }
}

