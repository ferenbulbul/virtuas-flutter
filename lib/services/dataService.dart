// data_service.dart

import 'dart:convert';
import 'package:flutter_application_1/models/applications_detail.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/clinic.dart';
import 'package:flutter_application_1/models/possible_applications.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String categoryGetUrl = 'https://localhost:7128/api/Category/Get';

  Future<List<Category>> fetchCategories() async {
    List<Category> data = [];

    try {
      final response = await http.get(Uri.parse(categoryGetUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        data = jsonData.map((json) => Category.fromJson(json)).toList();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
    return data;
  }

  Future<List<Category>> fetchSelectedCategories(int categoryId) async {
    final response = await http.post(Uri.parse(
        'https://localhost:7128/api/Category/GetByClinicId?clinicId=$categoryId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((cat) => Category.fromJson(cat)).toList();
    } else {
      throw Exception('Failed to load clinics');
    }
  }
}

Future<List<Question>> fetchQuestionsByCategoryId(int categoryId) async {
  List<Question> data = [];
  final String categoryGetUrl =
      'https://localhost:7128/api/Question/GetByCategoryId?categoryId=$categoryId';

  try {
    final response = await http.get(Uri.parse(categoryGetUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      data = jsonData.map((json) => Question.fromJson(json)).toList();
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading data: $e');
  }
  return data;
}

Future<void> editClinic(Clinic clinic) async {
  String apiUrl = 'https://localhost:7128/api/Clinics/Update';

  var postData = jsonEncode(({
    'id': clinic.id,
    'title': clinic.title,
    "description": clinic.description,
    "address": clinic.address,
    "webAddress": clinic.webAddress,
    "categories": []
  }));

  // POST isteği yapılıyor
  var response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: postData,
  );

  print("stop");
  // Başarılı giriş durumunda bir sonraki sayfaya yönlendirme (Navigator)
  // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
}

Future<List<Clinic>> fetchClinics() async {
  final response =
      await http.get(Uri.parse('https://localhost:7128/api/Clinics/Get'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((clinic) => Clinic.fromJson(clinic)).toList();
  } else {
    throw Exception('Failed to load clinics');
  }
}

Future<void> deleteClinic(int clinicId) async {
  final response = await http.delete(
      Uri.parse('https://localhost:7128/api/Clinics/Delete?id=$clinicId'));
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load clinics');
  }
}

Future<void> addCreditToclinic(int id, int newCredit) async {
  final response = await http.put(Uri.parse(
      'https://localhost:7128/api/Clinics/AddCreditToClinic?clinicId=$id&newCredit=$newCredit'));
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load clinics');
  }
}

Future<ApplicationDetailsResponse> fetchApplications(int userId) async {
  final response = await http.get(Uri.parse(
      'https://localhost:7128/api/Application/GetApplicationsWithAnswers?userId=$userId'));

  if (response.statusCode == 200) {
    return ApplicationDetailsResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load applications');
  }
}

final String updateUserUrl = 'https://localhost:7128/api/User/Update';

Future<User> fetchUser(int userId) async {
  final response = await http.post(
    Uri.parse('https://localhost:7128/api/User/Profile?userId=$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'userId': userId}),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

Future<User> updateUser(User user) async {
  final response = await http.post(
    Uri.parse(updateUserUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update user');
  }
}

Future<PossibleClientPreDataResponse> fetchApplicationsPreData(
    int clinicId) async {
  final response = await http.get(Uri.parse(
      'https://localhost:7128/api/Application/GetApplicationsPreData?clinicId=$clinicId'));

  if (response.statusCode == 200) {
    return PossibleClientPreDataResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load applications');
  }
}
