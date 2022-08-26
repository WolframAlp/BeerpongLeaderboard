import 'package:beerpong_leaderboard/screens/external_profile/external_profile.dart';
import 'package:beerpong_leaderboard/screens/friendlist/inputTextManager.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:avatars/avatars.dart';

class AddFriendScreen extends StatefulWidget {
  AddFriendScreen({Key? key}) : super(key: key);

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  AddFriendList addFriendList = AddFriendList();

  Container _getTextInputForm() {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.blue[300],
      height: 60.0,
      child: TextFormField(
        onChanged: (val) {
          context.read<AddFriendTextManager>().setNewInput(val);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          "Let's get some new ones!",
          style: kHintTextStyle,
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          _getTextInputForm(),
          addFriendList,
        ],
      ),
    );
  }
}

class AddFriendList extends StatefulWidget {
  AddFriendList({Key? key}) : super(key: key);

  @override
  State<AddFriendList> createState() => _AddFriendListState();
}

class _AddFriendListState extends State<AddFriendList> {
  String currentInput = "";
  List<String> relevantNames = [];
  int itemCount = 0;

  // Gets all the usernames in the database in a list
  Future<List<String>> _getAllUsernames(BuildContext context) async {
    return await context.read<DatabaseService>().getAllUsernames();
  }

  void setNewInput(String input) {
    currentInput = input.toLowerCase();
  }

  // Compare the current content of the input field to all the names and compile a list of names which overlap
  List<String> _getRelevantNames(List<String> allNames, UserModel user) {
    List<String> shortList = [];
    for (String name in allNames) {
      if (name.toLowerCase().startsWith(currentInput)) {
        if (!user.friends.contains(name) && user.name != name) {
          shortList.add(name);
        }
      }
      shortList.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });
    }
    return shortList;
  }

  // TODO make page for received requests

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<LastUserLoad>().lastLoad;
    return FutureBuilder<List<String>>(
        future: _getAllUsernames(context),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<AddFriendTextManager>(
              builder: ((context, manager, child) {
                try {
                  setNewInput(manager.currentInput);
                  relevantNames = _getRelevantNames(snapshot.data!, user);
                  if (relevantNames.isEmpty) {
                    return const Text("No users match input");
                  } else {
                    if (relevantNames.length > 10) {
                      itemCount = 10;
                    } else {
                      itemCount = relevantNames.length;
                    }

                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemCount,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddFriendUserTile(
                              username: relevantNames[index]);
                        },
                      ),
                    );
                  }
                } catch (e) {
                  print(e.toString());
                  return const Text("No users match input");
                }
              }),
            );
          } else if (snapshot.hasError) {
            return const Text("No users match input");
          } else {
            return const Text("No users match input");
          }
        });
  }
}

class AddFriendUserTile extends StatelessWidget {
  final String username;
  const AddFriendUserTile({required this.username});

  Future<Widget> _getPossibleFriendTile(
      String username, BuildContext context) async {
    UserModel user = context.read<LastUserLoad>().lastLoad;
    if (user.sendRequests.contains(username)) {
      return _getFriendAlreadyAddedTile(username, context);
    } else {
      return _getAddFriendTile(username, context);
    }
  }

  Future<Widget> _getFriendAlreadyAddedTile(
      String username, BuildContext context) async {
    return Container(
      height: 90,
      color: Colors.lightBlue,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Avatar(
                  shape: AvatarShape.circle(30.0),
                  useCache: true,
                  sources: [
                    GenericSource((await context
                            .read<StorageService>()
                            .getImageFromUsername(username, context))
                        .image)
                  ],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExternalProfile(name: username)));
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: profileValueLabelStyle,
                ),
                const Text(
                  "Already added <3",
                  style: kLabelStyle,
                ),
              ],
            ),
            const SizedBox(
              width: 75.0,
            )
          ]),
    );
  }

  Future<Widget> _getAddFriendTile(
      String username, BuildContext context) async {
    return Container(
      height: 90,
      color: Colors.lightBlue,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Avatar(
                  shape: AvatarShape.circle(30.0),
                  useCache: true,
                  sources: [
                    GenericSource((await context
                            .read<StorageService>()
                            .getImageFromUsername(username, context))
                        .image)
                  ],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExternalProfile(name: username)));
                  },
                ),
              ],
            ),
            Text(
              username,
              style: profileValueLabelStyle,
            ),
            Row(
              children: [
                TextButton.icon(
                  style: acceptButtonStyle,
                  onPressed: () async {
                    await context
                        .read<DatabaseService>()
                        .sendFriendRequest(username);
                    context.read<AddFriendTextManager>().resetTiles();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text("Add!!", style: kHintTextStyle),
                ),
                const SizedBox(
                  width: 10.0,
                )
              ],
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
        child: FutureBuilder<Widget>(
          future: _getPossibleFriendTile(username, context),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline,
                  color: Colors.red, size: 30.0);
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                  child: LoadingIcon(
                    size: 30.0,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
