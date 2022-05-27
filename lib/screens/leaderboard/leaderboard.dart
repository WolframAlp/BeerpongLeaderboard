import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getCostumNavigationBar(context, 0),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "The LeaderBoard",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
      ),
    );
  }
}
