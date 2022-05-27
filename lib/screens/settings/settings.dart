import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/auth.dart';

class Settings extends StatelessWidget {
  final AuthService _auth = AuthService();
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "Settings",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              // Navigator.pop(context);
              context.read<PageManager>().goToUsername;
            },
            icon: const Icon(Icons.verified_user),
            label: const Text("Intro"),
          ),
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout")),
        ],
      ),
    );
  }
}
