import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
abstract class GenreMovieEvent extends BaseEvent {
  final int id;
  final int pageKey;

  GenreMovieEvent(this.id, this.pageKey);
}

@immutable
 class GenreMovieDataEvent extends BaseEvent {
  final int id;
  final int pageKey;

  GenreMovieDataEvent(this.id, this.pageKey);


}
@immutable
class GenreMovieDataMoreEvent extends BaseEvent {
  final int id;
  final int pageKey;
  GenreMovieDataMoreEvent(this.id, this.pageKey);
}
