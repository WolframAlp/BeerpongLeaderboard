import 'package:beerpong_leaderboard/services/database.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool firstTimeLogin = false;

  FirebaseAuth get _authentication {
    return _auth;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Stream<User?> get currentUser {
    return _auth.userChanges();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in with email
  Future signInEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email
  Future registerEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      firstTimeLogin = true;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//   Future<UserCredential?> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     if (googleUser == null) {
//       return null;
//     }
//     List<String> possibleSigninMethods =
//         await _auth.fetchSignInMethodsForEmail(googleUser.email);
//     if (possibleSigninMethods.isEmpty) {
//       // DatabaseService database =
//       //     DatabaseService(name: googleUser.displayName, uid: "not needed");
//       // await database.createAllNewUser();
//       firstTimeLogin = true;
//     }

//     // Once signed in, return the UserCredential
//     return await _auth.signInWithCredential(credential);
//   }
}

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
