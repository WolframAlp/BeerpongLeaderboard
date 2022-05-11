import 'package:beerpong_leaderboard/screens/authenticate/authenticate.dart';
import 'package:beerpong_leaderboard/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    print(user);

    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}