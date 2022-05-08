import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // user collection
  // info : uid, name, win, games, elo, friends
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future createNewUser() async {
    // TODO needs to check if user already exists

    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': '',
      'wins': 0,
      'games': 0,
      'elo': 1000,
      'friends': [],
    });
  }

  Stream<List<UserModel>?> get users {
    return userCollection.snapshots().map(_usersFromSnapshot);
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

  Future updateUser() async {}
}