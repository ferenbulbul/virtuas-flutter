import 'package:flutter_application_1/models/question.dart';


class AddCategory {
  int id;
  String title;
  String description;
  int credit;
  List<Question> questions;

  AddCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.credit,
    required this.questions,
  });

  factory AddCategory.fromJson(Map<String, dynamic> json) {
    var questionsList = json['questions'] as List;
    List<Question> questions =
        questionsList.map((question) => Question.fromJson(question)).toList();

    return AddCategory(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      credit: json['credit'],
      questions: questions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'credit': credit,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
