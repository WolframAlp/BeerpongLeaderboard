import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/leaderboard/leaderboard_list.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  String? filterValue = "Top 10";
  Stream<List<Map>>? currentStream;

  void onChangedFliter(String? filter) async {
    if (filter != filterValue) {
      setState(() {
        filterValue = filter;
      });
    }
  }

  Future<void> _pullRefresh() async {}

  @override
  Widget build(BuildContext context) {
    switch (filterValue) {
      case "Top 10":
        currentStream = context.read<DatabaseService>().topTen;
        context.read<LastLeaderboardLoad>().setNewFilter(filterValue);
        break;
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<PageManager>().goBackOneScreen();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: StreamProvider<List<Map>>.value(
          initialData:
              context.read<LastLeaderboardLoad>().lastLoad.leaderboardMap,
          value: currentStream,
          child: Scaffold(
            bottomNavigationBar: getCostumNavigationBar(context, 0),
            appBar: AppBar(
              backgroundColor: Colors.blue[300],
              title: const Text(
                "The Board of Leaders!",
                style: kHintTextStyle,
              ),
              elevation: 0.0,
            ),
            body: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sort by : ",
                        style: profileLabelStyle,
                      ),
                      DropdownButton<String>(
                          value: filterValue,
                          icon: const Icon(Icons.arrow_downward),
                          style: profileValueLabelStyle,
                          underline: Container(
                            height: 1.0,
                            color: Colors.black,
                          ),
                          items: <String>["Top 10", "Friends", "All"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: onChangedFliter)
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  LeaderboardList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
