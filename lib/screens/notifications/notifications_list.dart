import 'package:avatars/avatars.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    // Load up user and separate notifications list
    UserModel user = Provider.of<UserModel>(context);
    context.read<LastUserLoad>().setNewModel(user);
    List notifications = user.notifications;

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationTile(notification: notifications[notifications.length - index -1]);
      },
    );
  }
}

// TODO need to be able to remove notifications

class NotificationTile extends StatelessWidget {
  final Map notification;
  // ignore: use_key_in_widget_constructors
  const NotificationTile({required this.notification});


  Future<Widget> _generateFriendRequest(Map notification, BuildContext context) async {
    return Container(
          height: 90,
          color: Colors.lightBlue,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(
                    shape: AvatarShape.circle(30.0),
                    useCache: true,
                    sources: [
                      GenericSource((await context
                              .read<StorageService>()
                              .getImageFromUsername(notification["name"]))
                          .image)
                    ]),
                Column(
                  children: [
                    const Text(
                      "Yay, you got a friend request ",
                      style: kLabelStyle,
                    ),
                    Row(children: [
                      Text(
                        "${notification['name']}",
                        style: profileValueLabelStyle,
                      ),
                      const Text(
                        " is waiting for your reponse..",
                        style: kLabelStyle,
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          style: acceptButtonStyle,
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text("Accept!!", style: kHintTextStyle),
                        ),
                        const SizedBox(width: 10,),
                        TextButton.icon(
                          style: declineButtonStyle,
                          onPressed: () {},
                          icon: const Icon(Icons.airline_stops),
                          label: const Text("decline", style: kHintTextStyle),
                        )
                      ],
                    )
                  ],
                ),
              ]),
        );
  }

  Future<Widget> _generateFriendAccepted(Map notification, BuildContext context) async {
    return Container(
          height: 90,
          color: Colors.lightBlue,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(
                    shape: AvatarShape.circle(30.0),
                    useCache: true,
                    sources: [
                      GenericSource((await context
                              .read<StorageService>()
                              .getImageFromUsername(notification["name"]))
                          .image)
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You got a new friend, let's get playing!",
                      style: kLabelStyle,
                    ),
                    Row(children: [
                      Text(
                        "${notification['name']}",
                        style: profileValueLabelStyle,
                      ),
                      const Text(
                        " says HI!",
                        style: kLabelStyle,
                      )
                    ])
                  ],
                ),
              ]),
        );
  }

  Future<Widget> _generateNotification(
      Map notification, BuildContext context) async {
    switch (notification['type']) {

      // Notification for having received a friend request
      case "friendRequest":
        return await _generateFriendRequest(notification, context);

      // Notification for getting accepted as friend
      case "friendRequestAccepted":
        return await _generateFriendAccepted(notification, context);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
        child: FutureBuilder<Widget>(
          future: _generateNotification(notification, context),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline,
                  color: Colors.red, size: 30.0);
            } else {
              return LoadingIcon();
            }
          },
        ),
      ),
    );
  }
}
