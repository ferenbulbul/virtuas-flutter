import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  int _userId = 0;

  int get userId => _userId;

  void setUserId(int id) {
    _userId = id;
    notifyListeners(); // Değişiklik olduğunda dinleyicilere bildir
  }
}
