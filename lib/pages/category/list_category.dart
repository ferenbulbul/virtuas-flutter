import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/add_category.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/services/categoryService.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  CategoryService _categoryService = CategoryService();
  List<AddCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    try {
      List<AddCategory> categories = await _categoryService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Failed to load categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          AddCategory category = _categories[index];
          return ListTile(
            title: Text(category.title),
            subtitle: Text(category.description),
            trailing: Text('${category.credit}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage(category: category),
                ),
              ).then((_) {
                _loadCategories(); // Detay sayfasından geri dönüldüğünde kategorileri tekrar yükle
              });
            },
          );
        },
      ),
    );
  }
}

class CategoryDetailPage extends StatefulWidget {
  final AddCategory category;

  CategoryDetailPage({required this.category});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late AddCategory _editedCategory;
  bool _isChanged = false;
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    _editedCategory = AddCategory(
      id: widget.category.id,
      title: widget.category.title,
      description: widget.category.description,
      credit: widget.category.credit,
      questions: List.from(widget.category.questions),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _isChanged ? _updateCategory : null,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteCategory,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: _editedCategory.title,
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                setState(() {
                  _editedCategory.title = value;
                  _isChanged = true;
                });
              },
            ),
            TextFormField(
              initialValue: _editedCategory.description,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  _editedCategory.description = value;
                  _isChanged = true;
                });
              },
            ),
            TextFormField(
              initialValue: _editedCategory.credit.toString(),
              decoration: InputDecoration(labelText: 'Credit'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _editedCategory.credit = int.tryParse(value) ?? 0;
                  _isChanged = true;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Questions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _editedCategory.questions.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _editedCategory.questions[index].title,
                          decoration: InputDecoration(
                              labelText: 'Question ${index + 1}'),
                          onChanged: (value) {
                            setState(() {
                              _editedCategory.questions[index].title = value;
                              _isChanged = true;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _editedCategory.questions.removeAt(index);
                            _isChanged = true;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateCategory() async {
    try {
      await _categoryService.updateCategory(_editedCategory);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Category updated successfully'),
      ));
      setState(() {
        _isChanged = false;
      });
    } catch (e) {
      print('Failed to update category: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update category'),
      ));
    }
  }

  void _deleteCategory() async {
    try {
      await _categoryService.deleteCategory(_editedCategory.id);
      Navigator.pop(context); // Detay sayfasını kapat
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Category deleted successfully'),
      ));
    } catch (e) {
      print('Failed to delete category: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete category'),
      ));
    }
  }

  void _addQuestion() {
    setState(() {
      _editedCategory.questions
          .add(Question(id: 0, title: '', categoryId: _editedCategory.id));
      _isChanged = true;
    });
  }
}
