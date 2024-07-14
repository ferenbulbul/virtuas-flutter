import 'package:flutter_application_1/models/answer.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/question.dart';

class SummaryData {
  final Category category;
  final Map<int, String> answers;
  final List<Question> questions;
  final List<Answer> answers2;

  SummaryData(
      {required this.category,
      required this.answers,
      required this.questions,
      required this.answers2});

  Map<String, dynamic> toJson() {
    return {
      'category': category.toJson(),
      'answers': answers.map((key, value) => MapEntry(key.toString(), value)),
      'questions': questions.map((question) => question.toJson()).toList()
    };
  }
}
