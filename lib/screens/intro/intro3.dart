import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage3() {
  return PageViewModel(
    title: "Friends",
    body: "Beerpong by yourself can be tiresome, so get some friends!\n",
    // TODO add image of generic profile and arrow to add friends
    image: buildImage("friends_with_beer.jpg"),
    // bodyWidget: Center(
    //   child: Column(
    //     children: const [
    //       Text("Beerpong by yourself can be tiresome, so get some friends!\n"),
    //     ],
    //   ),
    // ),
    footer: ElevatedButton.icon(
      icon: const Icon(Icons.person_add),
      onPressed: () {
        introKey.currentState?.animateScroll(0);
      },
      label: const Text(
        'Add Now!',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    decoration: pageDecoration,
  );
}
