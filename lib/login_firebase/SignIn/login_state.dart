import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState extends BaseState {
  final error;
  final bool isLoading;
  final bool loginSuccess;
  final bool loginFailure;

  //todo add the fields make rebuilding widget when changing
  @override
  List<Object?> get props => [error, isLoading, loginSuccess, loginFailure];

  LoginState({
    this.isLoading = false,
    this.error,
    this.loginSuccess = false,
    this.loginFailure = false
  });

  LoginState copyWith({
    bool? isLoading,
    var error,
    bool? loginSuccess,
    bool? loginFailure
  }) =>
      LoginState(
        isLoading: isLoading ?? false,
        error: error,
        loginSuccess: loginSuccess ?? this.loginSuccess,
        loginFailure: loginFailure ?? this.loginFailure
      );
}

