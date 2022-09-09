import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/preview/preview_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/video_search/video_search_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videos/videos_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/functions/translate.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/notifications.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  void _sendUrlFromClipboard() {
    FlutterClipboard.paste().then((value) {
      if (value.isNotEmpty) {
        context.read<VideoSearchBloc>().add(
              OnVideoSearchEvent(
                url: value,
              ),
            );

        FlutterClipboard.copy("null").then(
          (value) => log("Clipboard cleared"),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _sendUrlFromClipboard();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (appLifecycleState == AppLifecycleState.resumed) {
      context.read<VideosBloc>().add(const OnVideosEvent());

      _sendUrlFromClipboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          BlocListener<VideoSearchBloc, VideoSearchState>(
            listener: (context, state) {
              if (state is VideoSearchLoadingState) {
                sendSuccessNotification(
                  context,
                  t(context)!.videoSentToProcess,
                );
              }

              if (state is VideoSearchSuccessState) {
                context.read<VideosBloc>().add(
                      const OnVideosEvent(),
                    );

                sendSuccessNotification(
                  context,
                  t(context)!.videoConvertedSuccessfully,
                );
              }
            },
            child: BlocBuilder<VideosBloc, VideosState>(
              bloc: context.read<VideosBloc>()..add(const OnVideosEvent()),
              builder: (context, state) {
                if (state is VideosInitialState) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 130.0,
                    ),
                    itemCount: state.items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 9 / 16,
                    ),
                    itemBuilder: (context, index) {
                      return PreviewComponent(
                        item: state.items[index],
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 20.0,
            right: 20.0,
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () async {
                  // Open tiktok app
                  await LaunchApp.openApp(
                    androidPackageName: "com.zhiliaoapp.musically",
                    iosUrlScheme: "musically://",
                    appStoreLink:
                        "https://apps.apple.com/tn/app/tiktok/id835599320",
                    openStore: true,
                  );
                },
                child: Text(
                  t(context)!.addVideo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
