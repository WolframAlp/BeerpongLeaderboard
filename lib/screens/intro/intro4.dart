import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage4() {
  return PageViewModel(
    title: "Register Games",
    body:
        "1. Select the game size \n2. Add a friend \n3. Add opponents \n4. Add the score \n5. Gain Ranking",
    image: const Icon(Icons.fullscreen),
    decoration: pageDecoration,

// TODO add image of rigistration page

  );
}
