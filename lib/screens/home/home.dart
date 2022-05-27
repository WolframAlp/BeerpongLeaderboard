import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/home/user_list.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';


// Leaderboard of one's friends
// Push notifications on fridays
// Tournament option

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
      initialData: const [],
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: const Color(0xFF6CA8F1),
        bottomNavigationBar: getCostumNavigationBar(context, 2),
        body: UserList(),
      ),
    );
  }
}
