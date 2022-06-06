import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/registration/table_tile.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';

// Leaderboard of one's friends
// Push notifications on fridays
// Tournament option

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? gameSize = "6 cups";
  String? cupsLeftFriendly = "0";
  String? cupsLeftFoes = "0";
  String errorMessageOnAddGame = "";

  List<String> _getDropdownAvailableValues(String? value) {
    if (value == "6 cups") {
      return ["0", "1", "2", "3", "4", "5", "6"];
    } else {
      return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    }
  }

  // creates the drop downs for selecting number of cups left
  DropdownButton<String> _getDropdownForCupsLeftFriendly() {
    // Gets the available values for drop down
    List<String> availableValues = _getDropdownAvailableValues(gameSize);
    // creates drop down
    return DropdownButton(
        icon: const Icon(Icons.arrow_downward),
        style: profileValueLabelStyle,
        underline: Container(
          height: 1.0,
          color: Colors.black,
        ),
        items: availableValues.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: _onCupsLeftFriendlySelect,
        value: cupsLeftFriendly);
  }

  DropdownButton<String> _getDropdownForCupsLeftFoes() {
    // Gets the available values for drop down
    List<String> availableValues = _getDropdownAvailableValues(gameSize);
    // creates drop down
    return DropdownButton(
        icon: const Icon(Icons.arrow_downward),
        style: profileValueLabelStyle,
        underline: Container(
          height: 1.0,
          color: Colors.black,
        ),
        items: availableValues.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: _onCupsLeftFoeSelect,
        value: cupsLeftFoes);
  }

  // sets state for new friendly amount of cups
  void _onCupsLeftFriendlySelect(String? value) {
    setState(() => cupsLeftFriendly = value);
  }

  // sets state for new foe amount of cups
  void _onCupsLeftFoeSelect(String? value) {
    setState(() => cupsLeftFoes = value);
  }

  // reduces the amount of cups left if no longer available
  // then sets the new available amount of cups
  void _onSizeSelect(String? value) {
    if (!_getDropdownAvailableValues(value).contains(cupsLeftFriendly)) {
      setState(() => cupsLeftFriendly = "6");
    }
    if (!_getDropdownAvailableValues(value).contains(cupsLeftFoes)) {
      setState(() => cupsLeftFoes = "6");
    }
    setState(() => gameSize = value);
  }

  ElevatedButton _getAddGameButton() {
    return ElevatedButton(onPressed: (){}, child: Row(children: const [Text("Add game"), Icon(Icons.add_box_rounded)],)); // TODO needs styling (both button an text)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageManager>().goBackOneScreen();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF6CA8F1),
        bottomNavigationBar: getCostumNavigationBar(context, 2),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // main title of page
                const Text("Title Text"), // TODO needs styling

                // Row with drop down and label for drop down
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Game size: "), // TODO Needs styling
                    DropdownButton(
                        icon: const Icon(Icons.arrow_downward),
                        style: profileValueLabelStyle,
                        underline: Container(
                          height: 1.0,
                          color: Colors.black,
                        ),
                        items: <String>["6 cups", "10 cups"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: _onSizeSelect,
                        value: gameSize)
                  ],
                ),

                // The tile with the table and the add friends and foes
                TableTile(),

                // Row with drop downs for selecting cups left
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // TODO needs to be split on the middle though still next to one another (label dropdown)
                  children: [
                    const Text("Cups left : "),
                    _getDropdownForCupsLeftFriendly(),
                    const Text("Cups left: "),
                    _getDropdownForCupsLeftFoes(),
                  ],
                ),
                // error message
                Text(errorMessageOnAddGame), // TODO Needs an error message format

                // add game button
                _getAddGameButton(),
              ]),
        ),
      ),
    );
  }
}
