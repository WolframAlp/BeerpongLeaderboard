import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TrophyModel {
  String name = "";
  List<String> trophyNames = [];
  List<Timestamp> trophyTimes = [];
  List<Map> trophyMap = [];
  TrophyModel({this.name = "", this.trophyNames = const [], this.trophyTimes = const [], this.trophyMap = const []});

}

class LastTrophyLoad with ChangeNotifier, DiagnosticableTreeMixin {

  TrophyModel lastLoad = TrophyModel();

  void setNewModel(TrophyModel trophy){
    lastLoad = trophy;
  }

  void clearTrophy(){
    lastLoad = TrophyModel();
  }
}