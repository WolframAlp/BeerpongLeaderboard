import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage5() {
  return PageViewModel(
    title: "Rankings",
    body: "Gain ranking by winning, lose ranking by winning. \nRankings are based on your, your friend's and your opponents' ranking \n",
    image: const Icon(Icons.book),
    decoration: pageDecoration.copyWith(
      bodyFlex: 2,
      imageFlex: 4,
      bodyAlignment: Alignment.bottomCenter,
      imageAlignment: Alignment.topCenter,
    ),
    reverse: true,

// TODO image of generic leaderboard

  );
}
