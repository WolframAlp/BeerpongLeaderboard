import 'dart:io';

import 'package:beerpong_leaderboard/screens/friendlist/friendlist.dart';
import 'package:beerpong_leaderboard/screens/settings/settings.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:avatars/avatars.dart';

class ExternalProfileHead extends StatefulWidget {
  final UserModel user;
  const ExternalProfileHead({Key? key, required this.user}) : super(key: key);

  @override
  State<ExternalProfileHead> createState() => _ExternalProfileHeadState();
}

class _ExternalProfileHeadState extends State<ExternalProfileHead> {
  double iconSize = 32;
  List<Source> pictureSource = [];

  Column getLeftColumn(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            SizedBox(height: 50.0),
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
                const Text(
                  "Wins",
                  style: profileLabelStyle,
                ),
                Text(
                  "${user.wins}",
                  style: profileValueLabelStyle,
                ),
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
                const Text(
                  "Games",
                  style: profileLabelStyle,
                ),
                Text(
                  "${user.games}",
                  style: profileValueLabelStyle,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Avatar _getGenericAvatar(UserModel user) {
    return Avatar(
      sources: [
        GenericSource(
            Image.asset('assets/avatar_placeholder.jpg', width: 60).image)
      ],
      name: user.name.toString(),
      textStyle: const TextStyle(fontSize: 30.0),
      shape: AvatarShape.circle(55.0),
      useCache: true,
    );
  }

  Future<Avatar> _getAvatarFromUsername(
      String name, BuildContext context) async {
    Image image = await context
        .read<StorageService>()
        .getImageFromUsername(name, context);
    return Avatar(
      sources: [GenericSource(image.image)],
      name: name.toString(),
      textStyle: const TextStyle(fontSize: 30.0),
      shape: AvatarShape.circle(55.0),
      useCache: true,
    );
  }

  Widget _getProfileAvatar(UserModel user, BuildContext context) {
    return FutureBuilder<Avatar>(
      future: _getAvatarFromUsername(user.name, context),
      builder: (BuildContext context, AsyncSnapshot<Avatar> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return _getGenericAvatar(user);
        } else {
          return _getGenericAvatar(user);
        }
      },
    );
  }

  Column getCenterColumn(UserModel user, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 10.0),
        _getProfileAvatar(user, context),
        const SizedBox(height: 45.0),
        const Text(
          "Elo",
          style: profileLabelStyle,
        ),
        Text(
          "${user.elo}",
          style: profileValueLabelStyle,
        ),
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

// TODO add username to page?

  Column getRightColumn(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            SizedBox(height: 50.0),
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
                const Text(
                  "Win/Lose",
                  style: profileLabelStyle,
                ),
                Text(
                  "${getWinLose(user)}",
                  style: profileValueLabelStyle,
                ),
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
                const Text(
                  "Games",
                  style: profileLabelStyle,
                ),
                Text(
                  "${user.games}",
                  style: profileValueLabelStyle,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: getLeftColumn(widget.user),
          flex: 4,
        ),
        Expanded(
          child: getCenterColumn(widget.user, context),
          flex: 4,
        ),
        Expanded(
          child: getRightColumn(widget.user),
          flex: 4,
        ),
      ],
    );
  }
}
