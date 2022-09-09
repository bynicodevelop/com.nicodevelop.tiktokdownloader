part of 'videodownloader_bloc.dart';

abstract class VideoDownloaderState extends Equatable {
  const VideoDownloaderState();

  @override
  List<Object> get props => [];
}

class VideoDownloaderInitialState extends VideoDownloaderState {}
