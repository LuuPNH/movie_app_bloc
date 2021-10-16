import 'package:flutter/cupertino.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class PopularMovieEvent extends BaseEvent {
  final int pageKey;

  PopularMovieEvent(this.pageKey);
}

@immutable
class PopularMovieMoreEvent extends BaseEvent {
  final int pageKey;

  PopularMovieMoreEvent(this.pageKey);
}