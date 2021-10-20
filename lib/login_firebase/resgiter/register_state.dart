import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:meta/meta.dart';

@immutable
class RegisterState extends BaseState {
  final error;
  final bool isLoading;
  final bool registerSuccess;
  final bool registerFailure;

  //todo add the fields make rebuilding widget when changing
  @override
  List<Object?> get props => [error, isLoading, registerSuccess, registerFailure];

  RegisterState({
    this.isLoading = false,
    this.error,
    this.registerSuccess = false,
    this.registerFailure = false
  });

  RegisterState copyWith({
    bool? isLoading,
    var error,
    bool? registerSuccess,
    bool? registerFailure
  }) =>
      RegisterState(
          isLoading: isLoading ?? false,
          error: error,
          registerSuccess: registerSuccess ?? this.registerSuccess,
          registerFailure: registerFailure ?? this.registerFailure
      );
}

