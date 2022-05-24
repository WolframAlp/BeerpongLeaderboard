import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';

class ProfileHead extends StatefulWidget {
  const ProfileHead({Key? key}) : super(key: key);

  @override
  State<ProfileHead> createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {

  double iconSize = 32;

  Column getLeftColumn(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              color: Colors.grey[300],
              child: IconButton(
                color: Colors.black,
                onPressed: () {},
                icon: const Icon(Icons.person_add),
                iconSize: iconSize,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 110.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Wins", style: profileLabelStyle,),
                Text("${user.wins}", style: profileValueLabelStyle,),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Games", style: profileLabelStyle,),
                Text("${user.games}", style: profileValueLabelStyle,),
              ],
            )
          ],
        )
      ],
    );
  }

  Column getCenterColumn(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 10.0),
        ProfilePicture(
          name: user.name.toString(),
          radius: 55.0,
          fontsize: 30.0,
        ),
        const SizedBox(height: 45.0),
        const Text("Elo", style: profileLabelStyle,),
        Text("${user.elo}", style: profileValueLabelStyle,),
      ],
    );
  }

  double getWinLose(UserModel user) {
    if (user.games == 0) {
      return 0.0;
    } else {
      return (100 * (user.wins / user.games)).round() / 100;
    }
  }

  Column getRightColumn(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.grey[300],
              child: IconButton(
                color: Colors.black,
                onPressed: () {},
                icon: const Icon(Icons.settings),
                iconSize: iconSize,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 110.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Win/Lose", style: profileLabelStyle,),
                Text("${getWinLose(user)}", style: profileValueLabelStyle,),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Games", style: profileLabelStyle,),
                Text("${user.games}", style: profileValueLabelStyle,),
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    context.read<LastUserLoad>().setNewModel(user);
    return Row(
      children: [
        Expanded(
          child: getLeftColumn(user),
          flex: 4,
        ),
        Expanded(
          child: getCenterColumn(user),
          flex: 4,
        ),
        Expanded(
          child: getRightColumn(user),
          flex: 4,
        ),
      ],
    );
  }
}