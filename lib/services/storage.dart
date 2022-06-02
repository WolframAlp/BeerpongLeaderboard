import 'dart:io';
import 'package:beerpong_leaderboard/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class StorageService with ChangeNotifier, DiagnosticableTreeMixin {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? name;
  Image? image;
  StorageService({this.name});

  Future<String?> uploadImage(File file) async {
    var storageReference = storage.ref().child("user/profile/$name");
    TaskSnapshot uploadTask = await storageReference.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<Image> getUserImage(String url) async {
    image = Image.network(url);
    return image!;
  }

  Future<Image> getImageFromUsername(String username) async {
    DocumentSnapshot userData =
        await DatabaseService().userCollection.doc(username).get();
    String url = userData.get("avatarUrl");
    if (url.isNotEmpty) {
      return Image.network(url);
    } else {
      return Image.asset('assets/avatar_placeholder.jpg', width: 60);
    }
  }

  void setImageFromFile(File imageFile) {
    image = Image.file(imageFile);
  }
}
