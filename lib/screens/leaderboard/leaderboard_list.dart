import 'package:avatars/avatars.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/leaderboard.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LeaderboardList extends StatefulWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  Future<Map<String, String>> _getOtherUsersUrls(
      List<String> usernames, BuildContext context) async {
    return await context
        .read<DatabaseService>()
        .getListOfAvatarUrlsFromNames(usernames);
  }

  @override
  Widget build(BuildContext context) {
    List<Map>? leaderboardMap = Provider.of<List<Map>>(context);
    context.read<LastLeaderboardLoad>().setNewModel(leaderboardMap);
    String filter = context.read<LastLeaderboardLoad>().filter;

    List<String> otherUsers = [];
    for (var v in leaderboardMap) {
      otherUsers.add(v["name"]);
    }

    return SizedBox(
      height: 500.0,
      child: Card(
        borderOnForeground: true,
        color: Colors.blueAccent,
        elevation: 5.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Filtered by $filter",
                style: largeTitleLabelStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              FutureBuilder<Map<String, String>>(
                future: _getOtherUsersUrls(otherUsers, context),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, String>> snapshot) {
                  // Has data returns the list builder
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leaderboardMap.length,
                      itemBuilder: (context, index) {
                        return LeaderboardTile(
                          user: leaderboardMap[index],
                          index: index,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // error returns a container with a loading screen
                    return getLoadingFields(leaderboardMap, 60.0, 10.0, MediaQuery.of(context).size.height);
                  } else {
                    // no data returns a container with a loading screen
                    return getLoadingFields(leaderboardMap, 60.0, 10.0, MediaQuery.of(context).size.height);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  final Map user;
  final int index;
  const LeaderboardTile({required this.user, required this.index});

  Future<Widget> _generateLeaderboardTile(
      String name, int elo, BuildContext context) async {
    return ListTile(
      leading:
          Avatar(shape: AvatarShape.circle(30.0), useCache: true, sources: [
        GenericSource((await context
                .read<StorageService>()
                .getImageFromUsername(name, context))
            .image)
      ]),
      title: Text(
        name,
        style: profileLabelStyle,
      ),
      subtitle: Text(
        "$elo",
        // style: kLabelStyle,
      ),
      tileColor: Colors.amberAccent[300],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backColor = index.isEven ? Colors.white38 : Colors.white;

    String name = user["name"];
    int elo = user["elo"];
    return Card(
      color: backColor,
      child: FutureBuilder<Widget>(
        future: _generateLeaderboardTile(name, elo, context),
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
    );
  }
}
