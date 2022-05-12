import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage2() {
  return PageViewModel(
    title: "The plan from here",
    body:
        "1. Get to know the app\n2. Win a ton of games\n3. Brag to everyone\n4. Profit?",
    image: buildImage("basic_beerpong.png"),
    decoration: pageDecoration,
  );
}
