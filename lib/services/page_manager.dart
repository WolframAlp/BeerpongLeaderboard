import 'package:flutter/foundation.dart';
import 'dart:io';

class PageManager with ChangeNotifier, DiagnosticableTreeMixin {
  
  int currentPage = 0;
  List<int> pageTracker = [2];

  void goBackOneScreen() {
    if (pageTracker.length > 1){
      currentPage = pageTracker[pageTracker.length-2];
      pageTracker.removeLast();
      notifyListeners();
    } else {
      exit(0);
    }
  }

  void goToLeaderboard() {
    currentPage = 0;
    pageTracker.add(0);
    notifyListeners();
  }

  void goToNotifications() {
    currentPage = 1;
    pageTracker.add(1);
    notifyListeners();
  }

  void goToRegistration() {
    currentPage = 2;
    pageTracker.add(2);
    notifyListeners();
  }

  void goToRules() {
    currentPage = 3;
    pageTracker.add(3);
    notifyListeners();
  }

  void goToProfile() {
    currentPage = 4;
    pageTracker.add(4);
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