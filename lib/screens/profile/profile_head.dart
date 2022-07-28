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

class ProfileHead extends StatefulWidget {
  const ProfileHead({Key? key}) : super(key: key);

  @override
  State<ProfileHead> createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {
  double iconSize = 32;
  List<Source> pictureSource = [];

  Widget getLeftColumn(UserModel user) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                color: Colors.grey[300],
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FriendList()));
                  },
                  icon: const Icon(Icons.people),
                  iconSize: iconSize,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }

  // goes through the process of selecting and uploading a new profile picture
  Future _pickNewProfilePicture() async {
    XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      File imageFile = File(imagePicked.path);
      String? imageURL =
          await context.read<StorageService>().uploadImage(imageFile);
      if (imageURL != null) {
        await context.read<DatabaseService>().setImageURL(imageURL);
        context.read<UserModel>().avatarUrl = imageURL;
      }
      setState(() {
        pictureSource = [
          GenericSource(context.read<StorageService>().image!.image)
        ];
      });
      Navigator.pop(context);
    }
  }

  Widget getCenterColumn(UserModel user, BuildContext context) {
    if (context.read<StorageService>().image != null) {
      pictureSource = [
        GenericSource(context.read<StorageService>().image!.image)
      ];
    } else if (user.avatarUrl.isNotEmpty) {
      context.read<StorageService>().getUserImage(user.avatarUrl);
      pictureSource = [
        GenericSource(context.read<StorageService>().image!.image)
      ];
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Avatar(
            sources: pictureSource,
            name: user.name.toString(),
            textStyle: const TextStyle(fontSize: 30.0),
            shape: AvatarShape.circle(MediaQuery.of(context).size.width * 0.16),
            useCache: true,
            onTap: () {
              showModalBottomSheet<void>(
                  backgroundColor: Colors.lightBlueAccent,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 80.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              await _pickNewProfilePicture();
                            },
                            icon: const Icon(
                              Icons.image,
                              color: Colors.amberAccent,
                            ),
                            label: const Text("Pick new picture from gallery",
                                style: kLabelStyle),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(user.name.toString(), style: profileValueLabelStyle),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          const Text(
            "Elo",
            style: profileLabelStyle,
          ),
          Text(
            "${user.elo}",
            style: profileValueLabelStyle,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
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

  Widget getRightColumn(UserModel user) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.grey[300],
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  icon: const Icon(Icons.settings),
                  iconSize: iconSize,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    context.read<LastUserLoad>().setNewModel(user);
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, MediaQuery.of(context).padding.top, 0.0,
          MediaQuery.of(context).size.height * 0.04),
      child: Row(
        children: [
          Expanded(
            child: getLeftColumn(user),
            flex: 4,
          ),
          Expanded(
            child: getCenterColumn(user, context),
            flex: 4,
          ),
          Expanded(
            child: getRightColumn(user),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
