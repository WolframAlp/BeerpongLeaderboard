import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {context.read<PageManager>().goBackOneScreen(); return false;},
      child: Scaffold(
        bottomNavigationBar: getCostumNavigationBar(context, 3),
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: const Text(
            "The Rules",
            style: kHintTextStyle,
          ),
          elevation: 0.0,
        ),
      ),
    );
  }
}
