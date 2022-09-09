part of 'video_search_bloc.dart';

abstract class VideoSearchEvent extends Equatable {
  const VideoSearchEvent();

  @override
  List<Object> get props => [];
}

class OnVideoSearchEvent extends VideoSearchEvent {
  final String url;

  const OnVideoSearchEvent({
    required this.url,
  });

  @override
  List<Object> get props => [];
}
