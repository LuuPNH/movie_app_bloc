import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class SimilarMovieEvent extends BaseEvent {
  final int id;
  final int pageKey;

  SimilarMovieEvent(this.id, this.pageKey);
}

@immutable
class SimilarMovieMoreEvent extends BaseEvent {
  final int id;
  final int pageKey;

  SimilarMovieMoreEvent(this.id, this.pageKey);
}
