import 'package:beerpong_leaderboard/screens/home/home.dart';
import 'package:beerpong_leaderboard/screens/intro/intro_wrapper.dart';
import 'package:beerpong_leaderboard/screens/intro/set_username.dart';
import 'package:beerpong_leaderboard/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageWrapper extends StatelessWidget {
  PageWrapper({Key? key}) : super(key: key);

  bool usernameWasNull = false;

  @override
  Widget build(BuildContext context) {
    User? user;

    return Consumer<PageManager>(
      builder: (context, manager, child) {
        if (!usernameWasNull) {
          user = Provider.of<User?>(context);
        } else {
          user = FirebaseAuth.instance.currentUser;
        }

        if (user?.displayName == null) {
          usernameWasNull = true;
          return SetUsername(user: user);
        }
        switch (manager.currentPage) {
          case 0:
            return Home();
          case 1:
            return Profile();
          case 2:
            return SetUsername(user: user);
          case 3:
            return const OnBoardingPage();
        }
        return Home();
      },
    );
  }
}
