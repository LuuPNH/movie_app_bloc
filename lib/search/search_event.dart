import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class SearchMovieStartEvent extends BaseEvent {}


@immutable
class SearchMovieEvent extends BaseEvent {
  final String name;
  final int pageKey;

  SearchMovieEvent(this.name, this.pageKey);
}

@immutable
class SearchMovieMoreEvent extends BaseEvent {
  final String name;
  final int pageKey;

  SearchMovieMoreEvent(this.name, this.pageKey);
}
