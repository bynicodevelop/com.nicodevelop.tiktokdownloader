import 'package:com_nicodevelop_tiktokdownloader/services/videodownloader/videodownloader_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadVideoButtonComponent extends StatelessWidget {
  final Function()? onLoading;
  final Function()? onSuccess;
  final Function()? onError;

  final Widget child;

  const DownloadVideoButtonComponent({
    super.key,
    required this.child,
    this.onLoading,
    this.onSuccess,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoDownloaderBloc, VideoDownloaderState>(
      listener: (context, state) {
        if (state is VideoDownloaderLoadingState) {
          onLoading?.call();
          return;
        }

        if (state is VideoDownloaderSuccessState) {
          onSuccess?.call();
          return;
        }

        if (state is VideoDownloaderErrorState) {
          onError?.call();
          return;
        }
      },
      child: child,
    );
  }
}
