import 'package:flutter/foundation.dart';

class LeaderboardModel {
  List<Map> leaderboardMap = [];
  LeaderboardModel({this.leaderboardMap = const []});
}

class LastLeaderboardLoad with ChangeNotifier, DiagnosticableTreeMixin {

  LeaderboardModel lastLoad = LeaderboardModel();
  String filter = "";

  void setNewModel(List<Map> leaderboard){
    lastLoad.leaderboardMap = leaderboard;
  }

  void setNewFilter(String? filter){
    filter = filter;
  }

  void clearLeaderboard(){
    lastLoad = LeaderboardModel();
    filter = "";
    notifyListeners();
  }
}