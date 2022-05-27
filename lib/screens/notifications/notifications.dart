import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getCostumNavigationBar(context, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "The Notifications",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
      ),
    );
  }
}
