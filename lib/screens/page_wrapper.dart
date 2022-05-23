import 'package:beerpong_leaderboard/screens/home/home.dart';
import 'package:beerpong_leaderboard/screens/intro/intro_wrapper.dart';
import 'package:beerpong_leaderboard/screens/intro/set_username.dart';
import 'package:beerpong_leaderboard/screens/profile/profile.dart';
import 'package:beerpong_leaderboard/screens/rules/rules.dart';
import 'package:beerpong_leaderboard/screens/settings/settings.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageWrapper extends StatelessWidget {
  PageWrapper({Key? key}) : super(key: key);

  bool usernameWasNull = false;

  bool userExists(List<UserModel> users, String? username) {
    for (var i = 0; i < users.length; i++) {
      if (users[i].name == username) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return StreamBuilder<List<UserModel>>(
      stream: DatabaseService(uid: user?.uid, name: user?.displayName).users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserModel> userData = snapshot.data!;

          if (!usernameWasNull) {
            user = Provider.of<User?>(context);
          } else {
            user = FirebaseAuth.instance.currentUser;
          }

          if (user?.displayName == null) {
            usernameWasNull = true;
            return SetUsername(user: user);
          } else if (!userExists(userData, user?.displayName)) {
            usernameWasNull = true;
            return SetUsername(user: user);
          }

          return Consumer<PageManager>(
            builder: (context, manager, child) {
              switch (manager.currentPage) {
                case 0:
                  return Home();
                case 1:
                  return Profile();
                case 2:
                  return SetUsername(user: user);
                case 3:
                  return const OnBoardingPage();
                case 4:
                  return Settings();
                case 5:
                  return Rules();
              }
              return Home();
            },
          );
        } else {
          return LoadingIcon();
        }
      },
    );
  }
}
