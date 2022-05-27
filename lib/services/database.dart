import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';

class DatabaseService {
  final String? uid;
  final String? name;
  DatabaseService({this.uid, this.name});

  // user collection
  // info : uid, name, win, games, elo, friends
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference trophysCollection =
      FirebaseFirestore.instance.collection('trophys');

  // Create new user in database
  Future createNewUser() async {
    return await userCollection.doc(name).set({
      'uid': uid,
      'name': name,
      'wins': 0,
      'games': 0,
      'elo': 1000,
      'friends': [],
    });
  }

  // Create new database entry in trophies
  Future createtrophyUser() async {
    return await trophysCollection.doc(name).set({
      "CoolName": FieldValue.serverTimestamp(),
    });
  }

  // Add a new trophy to the current user
  Future addtrophyToUser(String trophyName) async {
    return await trophysCollection
        .doc(name)
        .set({trophyName: FieldValue.serverTimestamp()});
  }

  Future updateUserWinsAndGames() async {
    DocumentSnapshot document = await userCollection.doc(name).get();
    return await userCollection.doc(name).set({
      "games": document.get("games") + 1,
      "wins": document.get("wins") + 1,
    });
  }

  Future updateUserGames() async {
    DocumentSnapshot document = await userCollection.doc(name).get();
    return await userCollection.doc(name).set({
      "games": document.get("games") + 1,
    });
  }

  // Future completeTutorial() async {
  //   return await userCollection.doc(name).set({'tutorial_complete' : true});
  // }

  // Future<bool> tutorialComplete() async {
  //   DocumentSnapshot document = await userCollection.doc(name).get();
  //   return document.get('tutorial_complete');
  // }

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

  // Single user's trophies from document snapshot
  TrophyModel _trophysFromSnapshot(DocumentSnapshot snapshot) {
    List<String> trophyNames = [];
    List<Timestamp> trophyTimes = [];
    List<Map> trophyMap = [];
    Map data = snapshot.data() as Map<String, dynamic>;
    for (var key in data.keys) {
      trophyNames.add(key);
      trophyTimes.add(data[key]);
      trophyMap.add({key:data[key]});
    }
    return TrophyModel(trophyNames: trophyNames, trophyTimes: trophyTimes, trophyMap: trophyMap);
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
