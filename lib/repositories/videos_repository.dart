import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideosRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final StreamController<List<Map<String, dynamic>>> _streamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get videos => _streamController.stream;

  Future<void> getFile() async {
    log("Getting file");
    final User? user = _firebaseAuth.currentUser;

    if (user != null) {
      log("User is logged in");
      final List<Map<String, dynamic>> items = [];

      QuerySnapshot<Map<String, dynamic>> videoQuerySnapshot =
          await _firebaseFirestore
              .collection("apps")
              .doc(kAppId)
              .collection("users")
              .doc(user.uid)
              .collection("videos")
              .orderBy(
                "createdAt",
                descending: true,
              )
              .get();

      for (var element in videoQuerySnapshot.docs) {
        // TODO: not exists
        // print("$kAppId/videos/${user.uid}/${element.id}.jpg");
        final String previewUrl = await _firebaseStorage
            .ref("$kAppId/videos/${user.uid}/${element.id}.jpg")
            .getDownloadURL();

        items.add({
          "id": element.id,
          "previewUrl": previewUrl,
          ...element.data(),
        });
      }

      _streamController.add(items);
    }
  }
}
