part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosLoadingState extends VideosState {}

class VideosInitialState extends VideosState {
  final List<Map<String, dynamic>> items;

  const VideosInitialState({
    this.items = const [],
  });

  @override
  List<Object> get props => [
        items,
      ];
}
