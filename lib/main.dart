import 'package:beerpong_leaderboard/screens/friendlist/inputTextManager.dart';
import 'package:beerpong_leaderboard/screens/wrapper.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/services/storage.dart';
import 'package:beerpong_leaderboard/utilities/leaderboard.dart';
import 'package:beerpong_leaderboard/utilities/trophy.dart';
import 'package:beerpong_leaderboard/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PageManager()),
      ChangeNotifierProvider(create: (context) => LastUserLoad()),
      ChangeNotifierProvider(create: (context) => LastTrophyLoad()),
      ChangeNotifierProvider(create: (context) => LastLeaderboardLoad()),
      ChangeNotifierProvider(create: (context) => DatabaseService()),
      ChangeNotifierProvider(create: (context) => StorageService()),
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => AddFriendTextManager(),)
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: context.read<AuthService>().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Wrapper(),
      ),
    );
  }
}
