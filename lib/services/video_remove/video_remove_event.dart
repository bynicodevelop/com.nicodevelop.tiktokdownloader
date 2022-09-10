part of 'video_remove_bloc.dart';

abstract class VideoRemoveEvent extends Equatable {
  const VideoRemoveEvent();

  @override
  List<Object> get props => [];
}

class OnVideoRemoveEvent extends VideoRemoveEvent {
  final String id;

  const OnVideoRemoveEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}
