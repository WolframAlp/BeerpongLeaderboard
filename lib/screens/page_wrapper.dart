import 'package:beerpong_leaderboard/screens/intro/intro_wrapper.dart';
import 'package:beerpong_leaderboard/screens/intro/set_username.dart';
import 'package:beerpong_leaderboard/screens/leaderboard/leaderboard.dart';
import 'package:beerpong_leaderboard/screens/notifications/notifications.dart';
import 'package:beerpong_leaderboard/screens/profile/profile.dart';
import 'package:beerpong_leaderboard/screens/registration/registration.dart';
import 'package:beerpong_leaderboard/screens/rules/rules.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageWrapper extends StatelessWidget {
  PageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    if (context.read<AuthService>().firstTimeLogin) {
      return SetUsername(user: user);
    }

    return Consumer<PageManager>(
      builder: (context, manager, child) {
        switch (manager.currentPage) {
          case 0:
            return LeaderBoard();
          case 1:
            return const Notifications();
          case 2:
            return Registration();
          case 3:
            return const Rules();
          case 4:
            return Profile();
          case 5:
            return SetUsername(user: user);
          case 6:
            return const OnBoardingPage();
        }
        return Registration();
      },
    );
  }
}
