part of 'video_remove_bloc.dart';

abstract class VideoRemoveState extends Equatable {
  const VideoRemoveState();

  @override
  List<Object> get props => [];
}

class VideoRemoveInitialState extends VideoRemoveState {}

class VideoRemoveLoadingState extends VideoRemoveState {}

class VideoRemoveSuccessState extends VideoRemoveState {}

class VideoRemoveErrorState extends VideoRemoveState {
  final String message;

  const VideoRemoveErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
