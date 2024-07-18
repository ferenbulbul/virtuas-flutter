import 'dart:convert';
import 'package:flutter_application_1/models/add_category.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/question.dart';

class CategoryService {
  final String apiUrl = 'https://localhost:7128/api/Category/Get';

  Future<List<AddCategory>> getCategories() async {
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => AddCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> updateCategory(AddCategory category) async {
    String apiUrl = 'https://localhost:7128/api/Category/Update';

    var jsonBody = jsonEncode({
      'id': category.id,
      'title': category.title,
      'description': category.description,
      'credit': category.credit,
      'questions': category.questions.map((x) => x.toJson()).toList()
    });

    var response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('Category updated successfully!');
    } else {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    String apiUrl = 'https://localhost:7128/api/Category/Delete?id=$categoryId';

    var response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print('Category deleted successfully!');
    } else {
      throw Exception('Failed to delete category');
    }
  }
}
