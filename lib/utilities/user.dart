import 'package:flutter/foundation.dart';

class UserModel {

  String uid = "";
  int wins = 0;
  int games = 0;
  String name = "";
  int elo = 0;
  List friends = [];

  UserModel({this.uid = "", this.wins = 0, this.games = 0, this.name = "", this.elo = 0, this.friends = const []});

}


class LastUserLoad with ChangeNotifier, DiagnosticableTreeMixin {

  UserModel lastLoad = UserModel();

  void setNewModel(UserModel user){
    lastLoad = user;
  }

  void clearUser(){
    lastLoad = UserModel();
  }
}