import 'package:beerpong_leaderboard/screens/friendlist/inputTextManager.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:avatars/avatars.dart';

class FriendUserTile extends StatelessWidget {
  final String username;
  const FriendUserTile({required this.username});

  Future<Widget> _getFriendTile(
      String username, BuildContext context) async {
    return Container(
      height: 90,
      color: Colors.lightBlue,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Avatar(
                    shape: AvatarShape.circle(30.0),
                    useCache: true,
                    sources: [
                      GenericSource((await context
                              .read<StorageService>()
                              .getImageFromUsername(username, context))
                          .image)
                    ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: profileValueLabelStyle,
                ),
              ],
            ),
            const SizedBox(
              width: 75.0,
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
        child: FutureBuilder<Widget>(
          future: _getFriendTile(username, context),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline,
                  color: Colors.red, size: 30.0);
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                  child: LoadingIcon(
                    size: 30.0,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}