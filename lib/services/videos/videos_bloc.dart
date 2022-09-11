import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_tiktokdownloader/repositories/videos_repository.dart';
import 'package:equatable/equatable.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideosRepository _videosRepository = VideosRepository();

  VideosBloc() : super(const VideosInitialState()) {
    _videosRepository.videos.listen((event) {
      log("Video Bloc: Received new videos");

      add(OnVideoAddedEvent(
        items: event,
      ));
    });

    on<OnVideosEvent>((event, emit) async {
      emit(VideosInitialState(
        isLoading: true,
        items: state is VideosInitialState
            ? (state as VideosInitialState).items
            : [],
      ));

      await _videosRepository.getFile();
    });

    on<OnVideoAddedEvent>((event, emit) async {
      emit(VideosInitialState(
        isLoading: false,
        items: event.items,
        refresh: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}
