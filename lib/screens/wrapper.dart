import 'package:beerpong_leaderboard/screens/authenticate/authenticate.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beerpong_leaderboard/screens/page_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    print(user);
    bool logged_out = true;

    if (user == null) {
      logged_out = true;
      return Authenticate();
    } else {
      if (logged_out & (context.read<DatabaseService>().name == null)) {
        context.read<DatabaseService>().name = user.displayName;
        context.read<DatabaseService>().uid = user.uid;
        context.read<StorageService>().name = user.displayName;
        context.read<PageManager>().currentPage = 2;
        logged_out = false;
      }
      return StreamProvider<User?>.value(
        value: context.read<AuthService>().currentUser,
        initialData: user,
        child: PageWrapper(),
      );
    }
  }
}
