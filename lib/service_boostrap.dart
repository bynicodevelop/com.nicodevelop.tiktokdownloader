import 'package:com_nicodevelop_tiktokdownloader/services/video_remove/video_remove_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/video_search/video_search_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videodownloader/videodownloader_bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videos/videos_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceBootstrap extends StatelessWidget {
  final Widget child;

  const ServiceBootstrap({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoSearchBloc>(
          create: (context) => VideoSearchBloc(),
        ),
        BlocProvider<VideoDownloaderBloc>(
          create: (context) => VideoDownloaderBloc(),
        ),
        BlocProvider<VideosBloc>(
          lazy: false,
          create: (context) => VideosBloc()..add(const OnVideosEvent()),
        ),
        BlocProvider<VideoRemoveBloc>(
          lazy: false,
          create: (context) => VideoRemoveBloc(),
        ),
      ],
      child: child,
    );
  }
}
