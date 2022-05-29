import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/foundation.dart';

class DatabaseService with ChangeNotifier, DiagnosticableTreeMixin {
  String? uid;
  String? name;
  DatabaseService({this.uid, this.name});

  // user collection
  // info : uid, name, win, games, elo, friends
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference trophysCollection =
      FirebaseFirestore.instance.collection('trophys');

  final CollectionReference leaderboardCollection =
      FirebaseFirestore.instance.collection('leaderboard');

  // Create new user in database
  Future createNewUser() async {
    return await userCollection.doc(name).set({
      'uid': uid,
      'name': name,
      'wins': 0,
      'games': 0,
      'elo': 1000,
      'friends': [],
    }, SetOptions(merge: true));
  }

  // Create new database entry in trophies
  Future createtrophyUser() async {
    return await trophysCollection.doc(name).set({
      "CoolName": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Add a new trophy to the current user
  Future addtrophyToUser(String trophyName) async {
    return await trophysCollection.doc(name).set(
        {trophyName: FieldValue.serverTimestamp()},
        SetOptions(merge: true)); // This case merge, because we add a new value
  }

  Future updateUserWinsAndGames() async {
    return await userCollection.doc(name).update({
      "games": FieldValue.increment(
          1), // Adds 1 to the value in the database (can only be called once a second)
      "wins": FieldValue.increment(1),
    }); // This case use update because existing values are overwritten
  }

  Future updateUserGames() async {
    return await userCollection.doc(name).update({
      "games": FieldValue.increment(1),
    }); // This case use update because existing values are overwritten
  }

  // Create new database entry in leaderboard
  Future createrUserOnLeaderboard() async {
    return await leaderboardCollection.doc(name).set({
      "elo": 1000,
      "name": name,
    }, SetOptions(merge: true));
  }

  // Update the elo of user on leaderboard
  Future updateUserOnLeaderboard(int newValue) async {
    return await leaderboardCollection.doc(name).update({
      "elo": newValue,
    });
  }

  // Gets the documents for the top ten players on the leaderboard : https://cloud.google.com/firestore/docs/query-data/order-limit-data
  Future getTopTenPlayers() async {
    return leaderboardCollection
        .orderBy("elo")
        .limit(10)
        .snapshots()
        .map(_getLeaderboardMapList);
  }

  // All users list data stream
  Stream<List<UserModel>> get users {
    return userCollection.snapshots().map(_usersFromSnapshot);
  }

  // Current user data stream
  Stream<UserModel> get userData {
    return userCollection.doc(name).snapshots().map(_userDataFromSnapshot);
  }

  // Trophy stream
  Stream<TrophyModel> get trophys {
    return trophysCollection.doc(name).snapshots().map(_trophysFromSnapshot);
  }

  // Top ten leaderboard stream
  Stream<List<Map>> get topTen {
    return leaderboardCollection.orderBy("elo").limit(10).snapshots().map(_getLeaderboardMapList);
  }

  // TODO mapping in the streams could be done automatically from snapshots using the firebase build in costum objects methods : https://firebase.google.com/docs/firestore/manage-data/add-data#custom_objects

  // TODO what happens when offline ??, will information be updated later or never? what if you accept a game, is your elo updated, or do you need to accept it again later?

  // TODO for offline users it might be usefull to use the cache option : https://firebase.google.com/docs/firestore/query-data/get-data#source_options

  List<Map> _getLeaderboardMapList(QuerySnapshot snapshot) {
    List<Map> leaderboardMapList = [];
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      leaderboardMapList.add({"elo": doc.get("elo"), "name": doc.id});
    }
    leaderboardMapList.sort((a, b) => (b['elo']).compareTo(a['elo']));
    return leaderboardMapList;
  }

  // Single user's trophies from document snapshot
  TrophyModel _trophysFromSnapshot(DocumentSnapshot snapshot) {
    List<String> trophyNames = [];
    List<Timestamp> trophyTimes = [];
    List<Map> trophyMap = [];
    Map data = snapshot.data() as Map<String, dynamic>;
    for (var key in data.keys) {
      trophyNames.add(key);
      trophyTimes.add(data[key]);
      trophyMap.add({key: data[key]});
    }
    return TrophyModel(
        trophyNames: trophyNames,
        trophyTimes: trophyTimes,
        trophyMap: trophyMap);
  }

  // Single user from document snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot.get('uid'),
      wins: snapshot.get('wins'),
      games: snapshot.get('games'),
      name: snapshot.get('name'),
      elo: snapshot.get('elo'),
      friends: snapshot.get('friends'),
    );
  }

  // user list from snapshot
  List<UserModel> _usersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        uid: doc.get('uid'),
        wins: doc.get('wins'),
        games: doc.get('games'),
        name: doc.get('name'),
        elo: doc.get('elo'),
        friends: doc.get('friends'),
      );
    }).toList();
  }
}
