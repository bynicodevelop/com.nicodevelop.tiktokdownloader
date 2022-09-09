part of 'videodownloader_bloc.dart';

abstract class VideoDownloaderEvent extends Equatable {
  const VideoDownloaderEvent();

  @override
  List<Object> get props => [];
}

class OnVideoDownloaderEvent extends VideoDownloaderEvent {
  final String id;

  const OnVideoDownloaderEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}
