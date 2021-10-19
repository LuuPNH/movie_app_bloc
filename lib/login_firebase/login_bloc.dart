import 'package:movie_app_bloc/login_firebase/login_event.dart';
import 'package:movie_app_bloc/login_firebase/login_state.dart';
import 'package:movie_app_bloc/repository/user_repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class LoginBloc extends BaseBloc<LoginState> {

  final UserRepository userRepository = UserRepository();

  LoginBloc() : super(LoginState(isLoading: true));

  @override
  Stream<LoginState> mapEventToState(BaseEvent event) async* {
    if (event is LoginEvent) {
      try {
        await userRepository.signInWithCredentials(
            event.username, event.password);
        print("thanhcong");
        yield state.copyWith(isLoading: false, loginSuccess: true);
      } catch (error) {
        print(error);
        yield state.copyWith(isLoading: false, loginFailure: true);
      }
    }
  }
}
