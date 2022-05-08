import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  // ignore: use_key_in_widget_constructors
  const UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.yellow[user.wins*10],
          ),
          title: Text(
            user.uid,
            style: kLabelStyle,
          ),
          subtitle: Text(
            'ELO: ${user.elo}',
            style: kLabelStyle,
          ),
          tileColor: Colors.deepOrange[300],
        ),
      ),
    );
  }
}
