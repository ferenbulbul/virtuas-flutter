// Answer_model.dart

class Answer {
  int id;
  String title;
  int questionId;

  Answer({
    required this.id,
    required this.title,
    required this.questionId,
  });
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      title: json['title'],
      questionId: json['questionId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questionId': questionId,
    };
  }
}
