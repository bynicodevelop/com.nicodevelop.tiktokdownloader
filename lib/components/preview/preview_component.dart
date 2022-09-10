import 'package:com_nicodevelop_tiktokdownloader/components/buttons/download_video_button_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videodownloader/videodownloader_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/notifications.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewComponent extends StatelessWidget {
  final Map<String, dynamic> item;

  const PreviewComponent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(
              kDefaultPadding / 2,
            ),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.8),
                BlendMode.dstATop,
              ),
              image: NetworkImage(
                item["previewUrl"],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        DownloadVideoButtonComponent(
          onLoading: () {},
          onSuccess: () => sendSuccessNotification(
            context,
            t(context)!.videoDownloadedSuccessfully,
          ),
          onError: () => sendErrorNotification(
            context,
            t(context)!.videoDownloadedError,
          ),
          child: IconButton(
            onPressed: () {
              context.read<VideoDownloaderBloc>().add(OnVideoDownloaderEvent(
                    id: item["id"],
                  ));
            },
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            highlightColor: Colors.white.withOpacity(
              .3,
            ),
          ),
        ),
      ],
    );
  }
}
