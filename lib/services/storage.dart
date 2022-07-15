import 'dart:io';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StorageService with ChangeNotifier, DiagnosticableTreeMixin {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? name;
  Image? image;
  String? userUrl;
  StorageService({this.name});
  Map<String, Image> cachedImages = {};

  Future<String?> uploadImage(File file) async {
    var storageReference = storage.ref().child("user/profile/$name");
    TaskSnapshot uploadTask = await storageReference.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<Image> getUserImage(String url) async {
    if (image == null || url != userUrl) {
      userUrl = url;
      image = Image.network(url);
    }
    return image!;
  }

  Future<String> _getUrlFromUsername(
      String username, BuildContext context) async {
    if (context
        .read<DatabaseService>()
        .collectedUserUrls
        .containsKey(username)) {
      return context.read<DatabaseService>().collectedUserUrls[username]!;
    } else {
      DocumentSnapshot userData =
          await DatabaseService().userCollection.doc(username).get();
      return userData.get("avatarUrl");
    }
  }

  Future<Image> getImageFromUsername(
      String username, BuildContext context) async {
    if (cachedImages.keys.contains(username)) {
      return cachedImages[username]!;
    }

    String url = await _getUrlFromUsername(username, context);

    if (url.isNotEmpty) {
      Image loadedImage = Image.network(url);
      cachedImages[username] = loadedImage;
      return loadedImage;
    } else {
      return Image.asset('assets/avatar_placeholder.jpg', width: 60);
    }
  }

  void setImageFromFile(File imageFile) {
    image = Image.file(imageFile);
  }
}
