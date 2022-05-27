import 'package:flutter/foundation.dart';

class PageManager with ChangeNotifier, DiagnosticableTreeMixin {
  
  int currentPage = 0;

  void goToLeaderboard() {
    currentPage = 0;
    notifyListeners();
  }

  void goToNotifications() {
    currentPage = 1;
    notifyListeners();
  }

  void goToRegistration() {
    currentPage = 2;
    notifyListeners();
  }

  void goToRules() {
    currentPage = 3;
    notifyListeners();
  }

  void goToProfile() {
    currentPage = 4;
    notifyListeners();
  }

  void goToUsername() {
    currentPage = 5;
    notifyListeners();
  }

  void goToIntro() {
    currentPage = 6;
    notifyListeners();
  }

}