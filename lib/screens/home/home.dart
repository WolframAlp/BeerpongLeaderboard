import 'package:beerpong_leaderboard/screens/home/user_list.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
      initialData: const [],
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: const Color(0xFF6CA8F1),
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: const Text(
            "Home Screen",
            style: kHintTextStyle,
          ),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: context.read<PageManager>().goToProfile,
              icon: const Icon(Icons.person),
              label: const Text("Profile"),
            ),
            TextButton.icon(
              onPressed: context.read<PageManager>().goToUsername,
              icon: const Icon(Icons.verified_user),
              label: const Text("Intro"),
            ),
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout")),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
