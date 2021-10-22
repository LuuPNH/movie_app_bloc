import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class SearchMovieStartEvent extends BaseEvent {}


@immutable
class SearchMovieEvent extends BaseEvent {
  final String name;

  SearchMovieEvent(this.name);
}

@immutable
class SearchMovieMoreEvent extends BaseEvent {
  final String name;

  SearchMovieMoreEvent(this.name);
}
