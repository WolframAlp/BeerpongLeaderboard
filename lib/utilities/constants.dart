import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';



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
