import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class VideoGetDataEvent extends BaseEvent {
  final int id;

  VideoGetDataEvent(this.id);
}
