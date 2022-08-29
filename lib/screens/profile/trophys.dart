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
    return Card(
      borderOnForeground: true,
      color: Colors.blueAccent,
      elevation: 5.0,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: trophys.trophyMap.length,
              itemBuilder: (context, index) {
                return TrophyTile(trophy: trophys.trophyMap[index]);
              },
            ),
          ),
        ],
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
