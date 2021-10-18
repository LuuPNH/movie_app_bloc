import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class MovieDetailGetDataEvent extends BaseEvent {
  final int id;
  MovieDetailGetDataEvent(this.id);
}
