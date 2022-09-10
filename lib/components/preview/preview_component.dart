import 'package:com_nicodevelop_tiktokdownloader/components/buttons/download_video_button_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/components/confirm/confirm_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/video_remove/video_remove_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videodownloader/videodownloader_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videos/videos_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/notifications.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewComponent extends StatefulWidget {
  final Map<String, dynamic> item;

  const PreviewComponent({
    super.key,
    required this.item,
  });

  @override
  State<PreviewComponent> createState() => _PreviewComponentState();
}

class _PreviewComponentState extends State<PreviewComponent> {
  Widget modalBottomSeet(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
          bottom: kDefaultPadding * 2,
        ),
        child: Wrap(
          children: [
            BlocListener<VideoRemoveBloc, VideoRemoveState>(
              listener: (context, state) {
                if (state is VideoRemoveSuccessState) {
                  sendSuccessNotification(
                    context,
                    "Video removed",
                  );

                  context.read<VideosBloc>().add(
                        const OnVideosEvent(),
                      );
                }

                if (state is VideoRemoveErrorState) {
                  sendErrorNotification(
                    context,
                    "Can't remove video. Retry later.",
                  );
                }
              },
              child: ListTile(
                leading: const Icon(
                  Icons.delete_forever_rounded,
                ),
                title: const Text("Remove"),
                onTap: () async => showDialog(
                  context: context,
                  builder: (context) => ConfirmComponent(
                    title: "Remove",
                    content: "Are you sure you want to remove this video?",
                    cancelText: "Cancel",
                    confirmText: "Remove",
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      context.read<VideoRemoveBloc>().add(
                            OnVideoRemoveEvent(
                              id: widget.item["id"],
                            ),
                          );

                      Navigator.pop(context);
                    },
                  ),
                ).then(
                  (value) => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: modalBottomSeet,
      ),
      child: Stack(
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
                  widget.item["previewUrl"],
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
                      id: widget.item["id"],
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
      ),
    );
  }
}
