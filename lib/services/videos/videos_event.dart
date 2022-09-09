part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class OnVideosEvent extends VideosEvent {
  const OnVideosEvent();

  @override
  List<Object> get props => [];
}

class OnVideoAddedEvent extends VideosEvent {
  final List<Map<String, dynamic>> items;

  const OnVideoAddedEvent({
    required this.items,
  });

  @override
  List<Object> get props => [
        items,
      ];
}
