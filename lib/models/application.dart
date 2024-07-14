import 'package:flutter_application_1/models/answer_question.dart';

class Application {
  int? applicationId;
  DateTime? applicationDate;
  String? categoryTitle;
  String? categoryDescription;
  List<AnswerAndQuestion>? answers;

  Application({
    this.applicationId,
    this.applicationDate,
    this.categoryTitle,
    this.categoryDescription,
    this.answers,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationId: json['applicationId'],
      applicationDate: DateTime.parse(json['applicationDate']),
      categoryTitle: json['categoryTitle'],
      categoryDescription: json['categoryDescription'],
      answers: (json['answers'] as List)
          .map((answer) => AnswerAndQuestion.fromJson(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applicationId': applicationId,
      'applicationDate': applicationDate?.toIso8601String(),
      'categoryTitle': categoryTitle,
      'categoryDescription': categoryDescription,
      'answers': answers?.map((answer) => answer.toJson()).toList(),
    };
  }
}
