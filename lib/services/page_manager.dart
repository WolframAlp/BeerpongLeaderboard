import 'package:flutter/foundation.dart';

class PageManager with ChangeNotifier, DiagnosticableTreeMixin {
  
  int currentPage = 0;

  void goToHome() {
    currentPage = 0;
    notifyListeners();
  }

  void goToProfile() {
    currentPage = 1;
    notifyListeners();
  }

  void goToUsername() {
    currentPage = 2;
    notifyListeners();
  }

  void goToIntro() {
    currentPage = 3;
    notifyListeners();
  }

  void goToSettings() {
    currentPage = 4;
    notifyListeners();
  }

  void goToRules() {
    currentPage = 5;
    notifyListeners();
  }
}