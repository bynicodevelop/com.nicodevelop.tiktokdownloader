import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/repositories/videos_repository.dart';
import 'package:equatable/equatable.dart';

part 'video_remove_event.dart';
part 'video_remove_state.dart';

class VideoRemoveBloc extends Bloc<VideoRemoveEvent, VideoRemoveState> {
  final VideosRepository _videosRepository = VideosRepository();

  VideoRemoveBloc() : super(VideoRemoveInitialState()) {
    on<OnVideoRemoveEvent>((event, emit) async {
      emit(VideoRemoveLoadingState());

      try {
        await _videosRepository.removeVideo({
          "id": event.id,
        });

        emit(VideoRemoveSuccessState());
      } catch (e) {
        emit(VideoRemoveErrorState(message: e.toString()));
      }
    });
  }
}
