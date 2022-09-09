import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/theme.dart';
import 'package:com_nicodevelop_tiktokdownloader/firebase_options.dart';
import 'package:com_nicodevelop_tiktokdownloader/screens/home_screen.dart';
import 'package:com_nicodevelop_tiktokdownloader/service_boostrap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseStorage.instance.useStorageEmulator(
      host,
      9199,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      5001,
    );
  }

  MobileAds.instance.initialize();

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  // await FirebaseAuth.instance.signOut();

  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceBootstrap(
      child: MaterialApp(
        title: 'TikTok Downloader',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.themeLight(context),
        home: const HomeScreen(),
      ),
    );
  }
}
