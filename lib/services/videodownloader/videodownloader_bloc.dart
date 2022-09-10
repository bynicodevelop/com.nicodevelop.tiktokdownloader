import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/repositories/videos_repository.dart';
import 'package:equatable/equatable.dart';

part 'videodownloader_event.dart';
part 'videodownloader_state.dart';

class VideoDownloaderBloc
    extends Bloc<VideoDownloaderEvent, VideoDownloaderState> {
  final VideosRepository _videosRepository = VideosRepository();

  VideoDownloaderBloc() : super(VideoDownloaderInitialState()) {
    on<OnVideoDownloaderEvent>((event, emit) async {
      emit(VideoDownloaderLoadingState());

      try {
        await _videosRepository.downloadFileLocally(
          event.id,
        );

        emit(VideoDownloaderSuccessState());
      } catch (e) {
        print(e.toString());
        emit(VideoDownloaderErrorState(
          message: e.toString(),
        ));
      }
    });
  }
}
