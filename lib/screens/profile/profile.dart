import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/profile/profile_head.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);
    return StreamProvider<UserModel>.value(
      value: DatabaseService(
              uid: firebaseUser?.uid, name: firebaseUser?.displayName)
          .userData,
      initialData: context.read<LastUserLoad>().lastLoad,
      child: Scaffold(
        bottomNavigationBar: getCostumNavigationBar(context, 1),
        backgroundColor: const Color(0xFF6CA8F1),
        body: ListView(
          children: <Widget>[
            ProfileHead(),
            Container(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
