import 'package:com_nicodevelop_tiktokdownloader/services/video_search/video_search_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoSearchComponent extends StatelessWidget {
  final Widget child;
  final Function()? onLoading;
  final Function()? onSuccess;
  final Function()? onError;

  const VideoSearchComponent({
    super.key,
    required this.child,
    this.onLoading,
    this.onSuccess,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoSearchBloc, VideoSearchState>(
      listener: (context, state) {
        if (state is VideoSearchLoadingState) {
          onLoading?.call();
        }

        if (state is VideoSearchSuccessState) {
          onSuccess?.call();
        }

        if (state is VideoSearchErrorState) {
          onError?.call();
        }
      },
      child: child,
    );
  }
}
