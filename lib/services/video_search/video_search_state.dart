part of 'video_search_bloc.dart';

abstract class VideoSearchState extends Equatable {
  const VideoSearchState();

  @override
  List<Object> get props => [];
}

class VideoSearchInitialState extends VideoSearchState {}

class VideoSearchLoadingState extends VideoSearchState {}

class VideoSearchSuccessState extends VideoSearchState {}

class VideoSearchErrorState extends VideoSearchState {
  final String message;

  const VideoSearchErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
