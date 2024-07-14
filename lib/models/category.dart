// category_model.dart

class Category {
  int id;
  String title;
  String description;

  Category({
    required this.id,
    required this.title,
    required this.description,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
