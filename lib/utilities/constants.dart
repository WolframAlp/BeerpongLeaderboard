import 'package:beerpong_leaderboard/services/page_manager.dart';
import 'package:beerpong_leaderboard/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

//*****************************************
// Text styles
//*****************************************

// body style for intropage
const bodyStyle = TextStyle(fontSize: 19.0);

// hint style for input forms
const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

// Label style for headlines
const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

// Label style for profile info
const profileLabelStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
  fontSize: 20.0,
);

// Label style for profile info values
const profileValueLabelStyle = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 20.0,
);

// Label style for large titles
const  largeTitleLabelStyle = TextStyle(
  color: Colors.orangeAccent,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 28.0,
);

// Label style for small hidden text
const smallHiddenLabelStyle = TextStyle(
  color: Colors.white60,
  fontFamily: 'OpenSans',
  fontSize: 16.0,
);

//*****************************************
// Box decorators
//*****************************************

// decoration of containers for input forms
final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

//*****************************************
// Page decorators
//*****************************************

// decoration for intro pages
const pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
  bodyTextStyle: bodyStyle,
  bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
);

// Global keys
final introKey = GlobalKey<IntroductionScreenState>();

//*****************************************
// ButtonStyles
//*****************************************

// Button style for accept button in notifications
ButtonStyle acceptButtonStyle = ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.lightGreen[300];
                                } else {
                                  return Colors.lightGreen[600];
                                }
                              }),
                              elevation: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states){
                                if (states.contains(MaterialState.pressed)){
                                  return 0.0;
                                } else {
                                  return 5.0;
                                }
                              }));

// Button style for decline button in notifications
ButtonStyle declineButtonStyle = ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Color.fromARGB(255, 187, 142, 124);
                                } else {
                                  return Color.fromARGB(255, 209, 187, 173);
                                }
                              }),
                              elevation: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states){
                                if (states.contains(MaterialState.pressed)){
                                  return 0.0;
                                } else {
                                  return 2.0;
                                }
                              }));

//*****************************************
// Functions
//*****************************************

// build image from assests with given width
Widget buildImage(String assetName, [double width = 350]) {
  return Image.asset('assets/$assetName', width: width);
}

// build image form assets in full screen
Widget buildFullscreenImage(String assetName) {
  return Image.asset(
    'assets/$assetName',
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
  );
}

// On tapped method for navigation using navigation bar
void onTappedNavigation(BuildContext context, int newIndex, int currIndex) {
  if (newIndex == currIndex) {
    return;
  }
  switch (newIndex) {
    case 0:
      context.read<PageManager>().goToLeaderboard();
      break;
    case 1:
      context.read<PageManager>().goToNotifications();
      break;
    case 2:
      context.read<PageManager>().goToRegistration();
      break;
    case 3:
      context.read<PageManager>().goToRules();
      break;
    case 4:
      context.read<PageManager>().goToProfile();
      break;
  }
}

getLoadingFields(List tiles, double height, double size, double containerHeight) {
  return SizedBox(
    height: containerHeight,
    child: ListView.builder(
      itemCount: tiles.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
                margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                child: SizedBox(
                  height: height,
                  child: LoadingIcon(
                    size: size,
                  ),
                )));
      },
    ),
  );
}