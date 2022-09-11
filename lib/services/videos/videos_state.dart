part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosInitialState extends VideosState {
  final bool isLoading;
  final List<Map<String, dynamic>> items;
  final int refresh;

  const VideosInitialState({
    this.items = const [],
    this.isLoading = true,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        items,
        isLoading,
        refresh,
      ];
}
