import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "NAME OF USER",
          style: kHintTextStyle,
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: context.read<PageManger>().goToHome,
              icon: const Icon(Icons.home),
              label: const Text("Home")),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            label: const Text("Settings"),
          ),
        ],
      ),
    );
  }
}
