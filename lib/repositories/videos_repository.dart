import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/exceptions/unauthenticated_user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

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
        final String previewUrl = await _firebaseStorage
            .ref("apps/$kAppId/users/${user.uid}/media/${element.id}.jpg")
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

  Future<void> downloadFileLocally(
    Map<String, dynamic> data,
  ) async {
    assert(data["id"] != null);

    final User? user = _firebaseAuth.currentUser;

    if (user != null) {
      final Reference reference = _firebaseStorage
          .ref("apps/$kAppId/users/${user.uid}/media/${data["id"]}.mp4");

      final dir = await getApplicationDocumentsDirectory();

      final file = File("${dir.path}/${data["id"]}.mp4");

      await reference.writeToFile(file);

      log("File downloaded to: ${file.path}");

      await GallerySaver.saveVideo("${dir.path}/${data["id"]}.mp4");
    }
  }

  Future<void> removeVideo(Map<String, dynamic> data) async {
    assert(data["id"] != null);

    final User? user = _firebaseAuth.currentUser;

    if (user == null) {
      throw UnauthenticatedUserException(
        UnauthenticatedUserException.unauthenticatedUserException,
      );
    }

    await _firebaseFirestore
        .collection("apps")
        .doc(kAppId)
        .collection("users")
        .doc(user.uid)
        .collection("videos")
        .doc(data["id"])
        .delete();
  }
}
