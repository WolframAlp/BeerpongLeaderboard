import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/notifications/notifications_list.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageManager>().goBackOneScreen();
        return false;
      },
      child: StreamProvider<UserModel>.value(
        initialData: context.read<LastUserLoad>().lastLoad,
        value: context.read<DatabaseService>().userData,
        child: Scaffold(
          bottomNavigationBar: getCostumNavigationBar(context, 1),
          backgroundColor: Colors.blueAccent,
          body: NotificationList(),
        ),
      ),
    );
  }
}
