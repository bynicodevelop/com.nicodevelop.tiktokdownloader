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
      log("Listen event");

      add(OnVideoAddedEvent(
        items: event,
      ));
    });

    on<OnVideosEvent>((event, emit) async {
      await _videosRepository.getFile();
    });

    on<OnVideoAddedEvent>((event, emit) async {
      emit(VideosInitialState(
        items: event.items,
      ));
    });
  }
}
