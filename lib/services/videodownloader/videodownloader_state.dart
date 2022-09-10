part of 'videodownloader_bloc.dart';

abstract class VideoDownloaderState extends Equatable {
  const VideoDownloaderState();

  @override
  List<Object> get props => [];
}

class VideoDownloaderInitialState extends VideoDownloaderState {}

class VideoDownloaderLoadingState extends VideoDownloaderState {}

class VideoDownloaderSuccessState extends VideoDownloaderState {}

class VideoDownloaderErrorState extends VideoDownloaderState {
  final String message;

  const VideoDownloaderErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
