import 'package:com_nicodevelop_tiktokdownloader/utils/translate.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

class AddVideoButtonComponent extends StatelessWidget {
  const AddVideoButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Open tiktok app
        await LaunchApp.openApp(
          androidPackageName: "com.zhiliaoapp.musically",
          iosUrlScheme: "musically://",
          appStoreLink: "https://apps.apple.com/tn/app/tiktok/id835599320",
          openStore: true,
        );
      },
      child: Text(
        t(context)!.addVideo,
      ),
    );
  }
}
