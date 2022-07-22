import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrophyHead extends StatefulWidget {
  const TrophyHead({Key? key}) : super(key: key);

  @override
  State<TrophyHead> createState() => _TrophyHeadState();
}

class _TrophyHeadState extends State<TrophyHead> {
  @override
  Widget build(BuildContext context) {
    final trophys = Provider.of<TrophyModel>(context);
    context.read<LastTrophyLoad>().setNewModel(trophys);
    return Container(
      height: 319.0,
      child: Card(
        borderOnForeground: true,
        color: Colors.blueAccent,
        elevation: 5.0,
        child: SingleChildScrollView(
          // physics: ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Awesome Trophies",
                style: largeTitleLabelStyle,
              ),
              // TODO make generation by date or order
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trophys.trophyMap.length,
                itemBuilder: (context, index) {
                  return TrophyTile(trophy: trophys.trophyMap[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrophyTile extends StatelessWidget {
  final Map trophy;
  const TrophyTile({required this.trophy});

  @override
  Widget build(BuildContext context) {
    String name = trophy.keys.first;
    Timestamp time = trophy[name];
    return Card(
      // margin: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
      child: ListTile(
        leading: trophyFlavourImage[name],
        title: Text(
          name,
          style: profileLabelStyle,
        ),
        subtitle: Text(
          trophyFlavourText[name],
          style: kLabelStyle,
        ),
        tileColor: Colors.deepOrange[300],
        trailing: Text(DateFormat('dd-MM--yy').format(time.toDate()),
            style: smallHiddenLabelStyle),
      ),
    );
  }
}

const double leadingSize = 45.0;
Map trophyFlavourImage = {
  "CoolName": const Icon(
    Icons.cookie_outlined,
    size: leadingSize,
  ),
  "FirstWin": const Icon(Icons.nordic_walking, size: leadingSize),
  "TenWins": const Icon(Icons.ten_k, size: leadingSize),
  "Top100": const Icon(Icons.leaderboard, size: leadingSize),
};

Map trophyFlavourText = {
  "CoolName": "Cool Name Bro, tell it again! ",
  "FirstWin": "Letsa goo!",
  "TenWins": "Just ten more to go",
  "Top100": "Best of most of all",
};
