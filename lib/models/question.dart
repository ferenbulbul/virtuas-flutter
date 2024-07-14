class Question {
  final int id;
  final String title;
  final int categoryId;

  Question({required this.id, required this.title, required this.categoryId});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      categoryId: json['categoryId'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'categoryId': categoryId,
      };
}
