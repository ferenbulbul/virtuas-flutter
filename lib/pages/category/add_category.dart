import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/add_category.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/services/dataService.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  List<TextEditingController> questionControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: titleController,
              maxLength: 60,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (_) => _validateInputs(),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: descriptionController,
              maxLength: 200,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (_) => _validateInputs(),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: creditController,
              decoration:
                  InputDecoration(labelText: 'Credit', hintText: 'Max 100'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CustomRangeTextInputFormatter(),
              ],
              onChanged: (_) => _validateInputs(),
            ),
            SizedBox(height: 24.0),
            Text(
              'Questions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(
              children: List.generate(
                questionControllers.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: questionControllers[index],
                          maxLength: 200,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Question ${index + 1}',
                          ),
                          onChanged: (_) => _validateInputs(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          _removeQuestion(index);
                          _validateInputs(); // Validate inputs after removing
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            if (questionControllers.length < 5)
              ElevatedButton(
                onPressed: () {
                  _addQuestion();
                },
                child: Text('Add Question'),
              ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _isSaveButtonEnabled() ? _saveCategory : null,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSaveButtonEnabled() {
    // Save button enabled condition
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        creditController.text.isEmpty) {
      return false;
    }

    if (questionControllers.any((controller) => controller.text.isNotEmpty)) {
      return true;
    }

    return false;
  }

  void _validateInputs() {
    setState(() {});
  }

  void _saveCategory() {
    // Kullanıcıdan alınan bilgilerle yeni bir kategori ve sorular oluştur

    List<Question> questions = [];
    questionControllers.forEach((controller) {
      String questionText = controller.text.trim();
      if (questionText.isNotEmpty) {
        Question question = Question(categoryId: 0, id: 0, title: questionText);
        questions.add(question);
      }
    });

    AddCategory addCategory = AddCategory(
      id: 0,
      title: titleController.text,
      description: descriptionController.text,
      credit: int.parse(creditController.text),
      questions: questions,
    );

    // Oluşturulan kategori ve soruları kullanabiliriz (API isteği vs.)
    // Örneğin, bu bilgileri bir API'ye göndermek için bir fonksiyon çağrılabilir.
    _processCategory(addCategory);

    _clearFields();
    _navigateToHomePage();
  }

  void _processCategory(AddCategory addCategory) {
    createCategory(addCategory);
  }

  void _clearFields() {
    // Alanları temizle
    titleController.clear();
    descriptionController.clear();
    creditController.clear();
    questionControllers.forEach((controller) => controller.clear());
  }

  void _addQuestion() {
    if (questionControllers.length < 5) {
      setState(() {
        questionControllers.add(TextEditingController());
      });
    }
  }

  void _removeQuestion(int index) {
    setState(() {
      questionControllers.removeAt(index);
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacementNamed('/clientlandingpage');
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') return TextEditingValue();
    final value = int.parse(newValue.text);
    return TextEditingValue().copyWith(
      text: (value >= 1 && value <= 100) ? newValue.text : oldValue.text,
    );
  }
}