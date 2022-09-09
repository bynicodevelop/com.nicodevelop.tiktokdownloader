import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/repositories/video_search_repository.dart';
import 'package:equatable/equatable.dart';

part 'videodownloader_event.dart';
part 'videodownloader_state.dart';

class VideoDownloaderBloc
    extends Bloc<VideoDownloaderEvent, VideoDownloaderState> {
  // final VideoDownloaderRepository _videoSearchRepository =
  //     VideoDownloaderRepository();

  VideoDownloaderBloc() : super(VideoDownloaderInitialState()) {
    on<OnVideoDownloaderEvent>((event, emit) async {
      // await _videoSearchRepository.downloadFileLocally(event.id);
    });
  }
}
