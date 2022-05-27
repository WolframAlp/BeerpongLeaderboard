import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';

class CostumNavigationBar extends BottomNavigationBar {
  late int currIndex;
  late VoidCallback onTapped;

  CostumNavigationBar({
    Key? key,
    required currIndex,
    required onTapped,
  }) : super(
          key: key,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'LeaderBoard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.plus_one),
              label: 'Register',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Rules',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: currIndex,
          selectedItemColor: Colors.amber[800],
          onTap: onTapped,
        );
}

CostumNavigationBar getCostumNavigationBar (BuildContext context, int currIndex) {
  void onTapped (int newIndex) {
    onTappedNavigation(context, newIndex, currIndex);
  }
  return CostumNavigationBar(currIndex: currIndex, onTapped: onTapped);
}