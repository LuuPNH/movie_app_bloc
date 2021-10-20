import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class RegisterEvent extends BaseEvent {
  final String username;
  final String password;

  RegisterEvent(this.username, this.password);
}

@immutable
class RegisterFailEvent extends BaseEvent {}