import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/profile/profile_head.dart';
import 'package:beerpong_leaderboard/screens/profile/trophys.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _pullRefresh() async {}

  @override
  Widget build(BuildContext context) {
    // User? firebaseUser = Provider.of<User?>(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<PageManager>().goBackOneScreen();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: StreamProvider<TrophyModel>.value(
          initialData: context.read<LastTrophyLoad>().lastLoad,
          value: context.read<DatabaseService>().trophys,
          child: StreamProvider<UserModel>.value(
            initialData: context.read<LastUserLoad>().lastLoad,
            value: context.read<DatabaseService>().userData,
            child: Scaffold(
              bottomNavigationBar: getCostumNavigationBar(context, 4),
              backgroundColor: const Color(0xFF6CA8F1),
              body: Container(
                height: MediaQuery.of(context).size.height * 1.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: const <Widget>[
                      ProfileHead(),
                      TrophyHead(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
