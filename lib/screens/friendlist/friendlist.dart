// all friends and a search function

// a button for searching new people

// friend suggestions??

import 'package:beerpong_leaderboard/screens/friendlist/add_friend.dart';
import 'package:beerpong_leaderboard/screens/friendlist/friend_tile.dart';
import 'package:beerpong_leaderboard/screens/friendlist/inputTextManager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/services/auth.dart';

class FriendList extends StatefulWidget {
  FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final AuthService _auth = AuthService();

  String currentInput = "";
  List relevantNames = [];
  int itemCount = 0;

  void setNewInput(String input) {
    currentInput = input.toLowerCase();
  }

  // Compare the current content of the input field to all the names and compile a list of names which overlap
  List _getRelevantNames(List allNames) {
    if (currentInput.isEmpty){
      return allNames;
    }
    List<String> shortList = [];
    for (String name in allNames) {
      if (name.toLowerCase().startsWith(currentInput)) {
        shortList.add(name);
      }
      shortList.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });
    }
    return shortList;
  }

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

  Widget _getFull(List friends, BuildContext context) {
    return Consumer<FriendTextManager>(
      builder: ((context, manager, child) {
        setNewInput(manager.currentInput);
        relevantNames = _getRelevantNames(friends);
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: relevantNames.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return FriendUserTile(username: relevantNames[index]);
            },
          ),
        );
      }),
    );
  }

  Container _getTextInputForm() {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.blue[300],
      height: 60.0,
      child: TextFormField(
        onChanged: (val) {
          context.read<FriendTextManager>().setNewInput(val);
        },
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
          ),
          hintText: 'User',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  // make three tabs
  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<LastUserLoad>().lastLoad;
    List friends = user.friends;

    Widget mainWidget =
        friends.isEmpty ? _getEmpty() : _getFull(friends, context);

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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFriendScreen()));
              },
              icon: const Icon(Icons.person_add_alt),
              label: const Text("Add")),
        ],
      ),
      body: Column(children: [
        _getTextInputForm(),
        mainWidget,
      ]),
    );
  }
}
