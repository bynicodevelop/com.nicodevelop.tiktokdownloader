import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/exceptions/invalid_url_exception.dart';
import 'package:validators/validators.dart';

class VideoSearchRepository {
  Future<Map<String, dynamic>> runUploadTask(
    String url,
  ) async {
    if (!isURL(url)) {
      throw InvalidUrlException("Invalid URL");
    }

    final Uri uri = Uri.parse(url);

    if (!uri.host.contains("tiktok.com")) {
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
}
