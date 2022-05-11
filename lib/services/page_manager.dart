import 'package:flutter/foundation.dart';

class PageManger with ChangeNotifier, DiagnosticableTreeMixin {
  
  int currentPage = 0;

  void goToHome() {
    currentPage = 0;
    notifyListeners();
  }

  void goToProfile() {
    currentPage = 1;
    notifyListeners();
  }

  void goToIntro() {
    currentPage = 2;
    notifyListeners();
  }
}