import 'package:beerpong_leaderboard/screens/buttom_navigation.dart';
import 'package:beerpong_leaderboard/screens/external_profile/external_profile_head.dart';
import 'package:beerpong_leaderboard/screens/profile/profile_head.dart';
import 'package:beerpong_leaderboard/screens/profile/trophys.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ExternalProfile extends StatelessWidget {
  final String name;
  const ExternalProfile({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          name,
          style: kHintTextStyle,
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder<UserModel>(
              future: context.read<DatabaseService>().getSpecificUser(name),
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData) {
                  return ExternalProfileHead(user: snapshot.data!);
                } else if (snapshot.hasError) {
                  return getLoadingFields(
                      [1], 100.0, 100.0, MediaQuery.of(context).size.height);
                } else {
                  return getLoadingFields(
                      [1], 100.0, 100.0, MediaQuery.of(context).size.height);
                }
              }),
          const SizedBox(
            height: 40.0,
          ),
          // FutureBuilder(
          //     future:
          //         context.read<DatabaseService>().getSpecificUserTrophy(name),
          //     builder:
          //         (BuildContext context, AsyncSnapshot<TrophyModel> snapshot) {
          //       if (snapshot.hasData) {
          //         return Container();
          //         // return TrophyHead();
          //       } else if (snapshot.hasError) {
          //         return getLoadingFields(
          //             [1], 100.0, 100.0, MediaQuery.of(context).size.height);
          //       } else {
          //         return getLoadingFields(
          //             [1], 100.0, 100.0, MediaQuery.of(context).size.height);
          //       }
          //     }),
        ],
      ),
    );
  }
}
