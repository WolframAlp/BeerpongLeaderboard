// all friends and a search function

// a button for searching new people

// friend suggestions??

import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/auth.dart';

class FriendList extends StatelessWidget {
  final AuthService _auth = AuthService();
  FriendList({Key? key}) : super(key: key);

  Widget _getEmpty() {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 50.0,
            width: 300.0,
          ),
          Text(
            "WoW",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          SizedBox(
            height: 50.0,
            width: 300.0,
          ),
          Text(
            "Such Empty",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget _getFull() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<LastUserLoad>().lastLoad;
    List friends = user.friends;

    Widget mainWidget = friends.isEmpty ? _getEmpty() : _getFull();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "Friends are the best",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.person_add_alt),
              label: const Text("Add")),
        ],
      ),
      body: mainWidget,
    );
  }
}
