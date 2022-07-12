import 'package:flutter/foundation.dart';
import 'dart:io';

class AddFriendTextManager with ChangeNotifier, DiagnosticableTreeMixin {
  
  String currentInput = "";

  void setNewInput(String val) {
    currentInput = val;
    notifyListeners();
  }
  
  void resetTiles(){
    notifyListeners();
  }

}