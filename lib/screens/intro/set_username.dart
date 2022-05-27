// create it using an item list so you can scroll horizontally
// probably google to get the tiny dots at the buttom
//

// TODO make list of just usernames to check against

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:beerpong_leaderboard/utilities/constants.dart';
import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetUsername extends StatefulWidget {
  User? user;
  SetUsername({Key? key, required this.user}) : super(key: key);

  @override
  State<SetUsername> createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  String username = '';
  String error = '';
  bool loading = false;
  final _userFormKey = GlobalKey<FormState>();

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue[300],
      title: const Text(
        "WAZZAAARP",
        style: kHintTextStyle,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      actions: <Widget>[
        TextButton.icon(
            onPressed: context.read<PageManager>().goToRegistration,
            icon: const Icon(Icons.home),
            label: const Text("Home")),
        TextButton.icon(
          onPressed: context.read<PageManager>().goToIntro,
          icon: const Icon(Icons.settings),
          label: const Text("Settings"),
        ),
      ],
    );
  }

  Future<bool> _userNameExists(String? username) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();
    if (!snapShot.exists) {
      return false;
    } else {
      return true;
    }
  }

  String? _validateUsername(String? username) {
    if (username == null) {
      return "Please input username";
    }
    if (username.length < 6) {
      return "Username too short (min 6 char)";
    } else if (username.contains('@') ||
        username.contains('%') ||
        username.contains('?')) {
      return "Characters @, %, ? are not allowed";
    } else {
      return null;
    }
  }

  Widget _buildSetUsernameBtn(User? user) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          // elevation: 5.0,
          onPressed: () async {
            if (_userFormKey.currentState!.validate()) {
              setState(() => loading = true);
              bool exists = await _userNameExists(username);
              if (exists) {
                setState(() {
                  error = "Username Already in Use";
                  loading = false;
                });
              } else {
                error = '';
                await user?.updateDisplayName(username);
                await user?.reload();
                DatabaseService database = DatabaseService(uid: user?.uid, name: username);
                await database.createNewUser();
                await database.createtrophyUser();
                loading = false;
                context.read<PageManager>().goToIntro();
              }
            } else {
              error = '';
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text(
            'Set Username',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Text(
        error,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: _validateUsername,
            onChanged: (val) {
              setState(() => username = val);
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              hintText: 'Champion',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return loading
        ? LoadingIcon()
        : Scaffold(
            appBar: _buildAppBar(),
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: (() => FocusScope.of(context).unfocus()),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF73AEF5),
                            Color(0xFF61A4F1),
                            Color(0xFF478DE0),
                            Color(0xFF398AE5),
                          ],
                          stops: [0.1, 0.4, 0.7, 0.9],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 120.0,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Get Ready!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              const Text(
                                "Before we get started chose the name of a champion",
                                // maybe some colors in the text, like CHOSE and CHAMPION
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Form(
                                key: _userFormKey,
                                child: Column(
                                  children: [
                                    _buildUsernameTF(),
                                    const SizedBox(height: 30.0),
                                  ],
                                ),
                              ),
                              _buildSetUsernameBtn(user),
                              _buildErrorMessage(),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
