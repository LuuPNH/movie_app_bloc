import 'package:movie_app_bloc/model/video/video.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class VideoState extends BaseState {
  final error;
  final bool isLoading;
  final  item;

  @override
  // TODO: implement props
  List<Object?> get props => [error, isLoading, item];

  VideoState(
      {this.error, this.isLoading = false, this.item = const []});

  VideoState copyWith({
    bool? isLoading,
    var error,
    Video? item,
  }) =>
      VideoState(
          error: error,
          isLoading: isLoading ?? false,
          item: item ?? this.item);
}
