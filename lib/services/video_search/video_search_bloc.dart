import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/repositories/video_search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:validators/validators.dart';

part 'video_search_event.dart';
part 'video_search_state.dart';

class VideoSearchBloc extends Bloc<VideoSearchEvent, VideoSearchState> {
  final VideoSearchRepository _videoSearchRepository = VideoSearchRepository();

  VideoSearchBloc() : super(VideoSearchInitialState()) {
    on<OnVideoSearchEvent>((event, emit) async {
      if (isURL(event.url)) {
        emit(VideoSearchLoadingState());

        try {
          await _videoSearchRepository.runUploadTask(
            event.url,
          );

          emit(VideoSearchSuccessState());
        } catch (e) {
          emit(VideoSearchErrorState(
            message: e.toString(),
          ));
        }
      } else {
        emit(const VideoSearchErrorState(
          message: "Invalid URL",
        ));
      }
    });
  }
}
