import 'package:beerpong_leaderboard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class AuthService with ChangeNotifier, DiagnosticableTreeMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get _authentication {
    return _auth;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in anonymously
  // Future signInAnon() async {
  //   try {
  //     UserCredential user_credential = await _auth.signInAnonymously();
  //     User? user = user_credential.user;
  //     return user;
  //   }
  //   catch(e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email
  Future signInEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register with email
  Future registerEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      // await DatabaseService(uid: user?.uid).createNewUser();
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
    return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}