import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

PageViewModel GetIntroPage1() {
  return PageViewModel(
    title: "BeerBoard",
    body:
        "WHO IS THE BEST?? \nSometimes its defficult to remember the next day... \n\nBeerBoard takes care of that. Get accurate scores for your beerpong performance.",
    image: buildImage("beer_with_foam.jpg"),
    decoration: pageDecoration,
  );
}
