import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage6() {
  return PageViewModel(
    title: "Tournaments",
    body: "Tournaments in your area are posted \nan open to registration. \nGet tournamenting.",
    // bodyWidget: Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: const [
    //     Text("Tournaments in your area are posted \nan open to registration. \nGet tournamenting.", style: bodyStyle),
    //     // Icon(Icons.edit),
    //     // Text(" to edit a post", style: bodyStyle),
    //   ],
    // ),
    decoration: pageDecoration.copyWith(
      bodyFlex: 2,
      imageFlex: 4,
      bodyAlignment: Alignment.bottomCenter,
      imageAlignment: Alignment.topCenter,
    ),
    image: const Icon(Icons.money),
    reverse: true,
  );
}
