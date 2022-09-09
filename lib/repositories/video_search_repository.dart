import 'dart:developer';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/exceptions/invalid_url_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:validators/validators.dart';

class VideoSearchRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> runUploadTask(
    String url,
  ) async {
    // TODO: Verifier que c'est bien un lien tiktok
    if (!isURL(url)) {
      throw InvalidUrlException("Invalid URL");
    }

    log("Sending request to cloud function: $url");

    HttpsCallableResult result = await FirebaseFunctions.instance
        .httpsCallable('downloadVideoFromUrl')
        .call({
      'url': url,
      'appid': kAppId,
    });

    return result.data;
  }

  Future<void> downloadFileLocally(
    String id,
  ) async {
    final Reference reference = _firebaseStorage.ref("$kAppId/videos/$id.mp4");

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$id.mp4");

    await reference.writeToFile(file);

    print("File downloaded to: ${file.path}");

    await GallerySaver.saveVideo("${dir.path}/$id.mp4");
  }
}
