import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/answer.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/pages/client/summary.dart';
import 'package:flutter_application_1/services/categoryService.dart';
import 'package:flutter_application_1/services/dataService.dart'; // Assuming DataService contains deleteQuestionById
import 'package:flutter_application_1/models/summary.dart'; // Import your model

class CategoryDetailPage extends StatefulWidget {
  final Category? category;

  CategoryDetailPage({required this.category});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<Question> questions = [];
  Map<int, String> answers = {};
  List<Answer> answers2 = [];

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      fetchDataOnLoad();
    }
  }

  void fetchDataOnLoad() async {
    try {
      List<Question> fetchedData =
          await fetchQuestionsByCategoryId(widget.category!.id);
      setState(() {
        questions = fetchedData;
      });
    } catch (e) {
      // Handle error gracefully, e.g., show a snackbar or retry mechanism
      print('Error fetching data: $e');
    }
  }

  void deleteQuestion(int questionId) async {
    try {
      await CategoryService().deleteCategory(
          questionId); // Example usage, adjust as per your actual implementation
      setState(() {
        questions.removeWhere((question) => question.id == questionId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Question deleted successfully')),
      );
    } catch (e) {
      print('Error deleting question: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete question')),
      );
    }
  }

  void saveAndNavigateToSummaryPage() {
    SummaryData summaryData = SummaryData(
        category: widget.category!,
        answers: answers,
        questions: questions,
        answers2: answers2);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(summaryData: summaryData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category?.title ?? 'Category Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kategori Adı: ${widget.category?.title ?? 'Unknown'}'),
            SizedBox(height: 8),
            Text(
                'Açıklama: ${widget.category?.description ?? 'No description'}'),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Question question = questions[index];
                  return Dismissible(
                    key: Key(question.id.toString()),
                    onDismissed: (direction) {
                      deleteQuestion(question.id);
                    },
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Question'),
                            content: Text(
                                'Are you sure you want to delete this question?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your answer here',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                answers[question.id] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: saveAndNavigateToSummaryPage,
                child: Text('Save and View Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
