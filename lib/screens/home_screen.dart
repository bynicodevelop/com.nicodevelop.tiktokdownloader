import 'dart:developer';

import 'package:com_nicodevelop_tiktokdownloader/components/bootstrap/bootstrap_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/buttons/add_video_button_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/clipboard/clipboard_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/video_search/video_search_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/videos/video_list_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/video_search/video_search_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videos/videos_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/notifications.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoSearchComponent(
        onLoading: () {
          sendSuccessNotification(
            context,
            t(context)!.videoSentToProcess,
          );
        },
        onSuccess: () {
          sendSuccessNotification(
            context,
            t(context)!.videoConvertedSuccessfully,
          );

          log("VideoSearchComponent: Success - Refreshing videos");
          context.read<VideosBloc>().add(const OnVideosEvent());
        },
        // Not return error
        onError: () {},
        child: ClipboardComponent(
          onClipboardChanged: (value) {
            context.read<VideoSearchBloc>().add(
                  OnVideoSearchEvent(
                    url: value,
                  ),
                );
          },
          child: BlocBuilder<VideosBloc, VideosState>(
            bloc: context.read<VideosBloc>()..add(const OnVideosEvent()),
            builder: (context, state) {
              final VideosInitialState videoState =
                  (state as VideosInitialState);
              if (videoState.items.isEmpty && videoState.isLoading == false) {
                return const BootstrapComponent();
              }

              return VideoListComponent(
                items: videoState.items,
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding * 3,
        ),
        height: 120,
        width: double.infinity,
        child: const AddVideoButtonComponent(),
      ),
    );
  }
}
