import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';


@immutable
class GenresMovieEvent extends BaseEvent {
  final int id;
  GenresMovieEvent(this.id);
}

@immutable
class GenresMovieMoreEvent extends BaseEvent {
  final int id;

  GenresMovieMoreEvent(this.id);
}
