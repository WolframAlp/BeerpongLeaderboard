import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/leaderboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LeaderboardList extends StatefulWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  @override
  Widget build(BuildContext context) {

    List<Map>? leaderboardMap = Provider.of<List<Map>>(context);
    context.read<LastLeaderboardLoad>().setNewModel(leaderboardMap);
    String filter = context.read<LastLeaderboardLoad>().filter;

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
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leaderboardMap.length,
                itemBuilder: (context, index) {
                  return LeaderboardTile(user: leaderboardMap[index], index: index,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO set up with profile picture like in notifications+++++++

class LeaderboardTile extends StatelessWidget {
  final Map user;
  final int index;
  const LeaderboardTile({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {

    Color backColor = index.isEven ? Colors.white38 : Colors.white;

    String name = user["name"];
    int elo = user["elo"];
    return Card(
      color: backColor,
      child: ListTile(
        // leading: trophyFlavourImage[name], // TODO profile picture
        title: Text(
          name,
          style: profileLabelStyle,
        ),
        subtitle: Text(
          "$elo",
          // style: kLabelStyle,
        ),
        tileColor: Colors.amberAccent[300],
      ),
    );
  }
}
