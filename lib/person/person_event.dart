import 'package:flutter/cupertino.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class PersonEvent extends BaseEvent {
  final int pageKey;

  PersonEvent(this.pageKey);
}

@immutable
class PersonMoreEvent extends BaseEvent {
  final int pageKey;
  PersonMoreEvent(this.pageKey);
}
