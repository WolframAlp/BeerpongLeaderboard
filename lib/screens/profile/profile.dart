import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/profile/profile_head.dart';
import 'package:beerpong_leaderboard/screens/profile/trophys.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/trophy.dart';
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
    // User? firebaseUser = Provider.of<User?>(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<PageManager>().goBackOneScreen();
        return false;
      },
      child: StreamProvider<TrophyModel>.value(
        initialData: context.read<LastTrophyLoad>().lastLoad,
        value: context.read<DatabaseService>().trophys,
        child: StreamProvider<UserModel>.value(
          initialData: context.read<LastUserLoad>().lastLoad,
          value: context.read<DatabaseService>().userData,
          child: Scaffold(
            bottomNavigationBar: getCostumNavigationBar(context, 4),
            backgroundColor: const Color(0xFF6CA8F1),
            body: Column(
              children: const <Widget>[
                ProfileHead(),
                SizedBox(
                  height: 40.0,
                ),
                TrophyHead(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
