part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosInitialState extends VideosState {
  final bool isLoading;
  final List<Map<String, dynamic>> items;

  const VideosInitialState({
    this.items = const [],
    this.isLoading = true,
  });

  @override
  List<Object> get props => [
        items,
        isLoading,
      ];
}
