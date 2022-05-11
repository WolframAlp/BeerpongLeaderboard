import 'package:beerpong_leaderboard/screens/authenticate/authenticate.dart';
import 'package:beerpong_leaderboard/screens/home/home.dart';
import 'package:beerpong_leaderboard/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageManger>(
      builder: (context, manager, child) {
        switch(manager.currentPage) {
          case 0:
          return Home();
          case 1:
          return Profile();
        }
        return Home();
      },
    );
  }
}