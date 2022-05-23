import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getCostumNavigationBar(context, 2),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "The Rules",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
      ),
    );
  }
}
