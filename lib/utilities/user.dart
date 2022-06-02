import 'package:flutter/foundation.dart';

class UserModel {
  String uid = "";
  int wins = 0;
  int games = 0;
  String name = "";
  int elo = 0;
  List friends = [];
  List friendRequests = [];
  List sendRequests = [];
  String avatarUrl = "";
  List notifications = [];

  UserModel({
    this.uid = "",
    this.wins = 0,
    this.games = 0,
    this.name = "",
    this.elo = 0,
    this.friends = const [],
    this.friendRequests = const [],
    this.sendRequests = const [],
    this.avatarUrl = "",
    this.notifications = const [],
  });
}

class LastUserLoad with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel lastLoad = UserModel();

  void setNewModel(UserModel user) {
    lastLoad = user;
  }

  void clearUser() {
    lastLoad = UserModel();
  }
}
