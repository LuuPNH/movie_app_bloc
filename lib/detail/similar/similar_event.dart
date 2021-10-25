import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class SimilarMovieEvent extends BaseEvent {
  final int id;

  SimilarMovieEvent(this.id);
}

@immutable
class SimilarMovieMoreEvent extends BaseEvent {
  final int id;

  SimilarMovieMoreEvent(this.id);
}
