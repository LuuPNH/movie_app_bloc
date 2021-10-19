import 'package:meta/meta.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class LoginEvent extends BaseEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}
