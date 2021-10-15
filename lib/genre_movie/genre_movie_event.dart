import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class GenresMovieEvent extends BaseEvent {
  final int id;
  final int pageKey;

  GenresMovieEvent(this.id, this.pageKey);
}

@immutable
class GenresMovieMoreEvent extends BaseEvent {
  final int id;
  final int pageKey;

  GenresMovieMoreEvent(this.id, this.pageKey);
}
