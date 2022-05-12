import 'package:beerpong_leaderboard/screens/wrapper.dart';
import 'package:beerpong_leaderboard/services/auth.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PageManager()),
    ],
    child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Wrapper(),
      ),
    );
  }
}
