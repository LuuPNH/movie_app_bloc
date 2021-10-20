import 'package:movie_app_bloc/login_firebase/resgiter/register_event.dart';
import 'package:movie_app_bloc/login_firebase/resgiter/register_state.dart';
import 'package:movie_app_bloc/repository/user_repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class RegisterBloc extends BaseBloc<RegisterState> {

  final UserRepository userRepository = UserRepository();

  RegisterBloc() : super(RegisterState(isLoading: true, registerFailure: false, registerSuccess: false));

  @override
  Stream<RegisterState> mapEventToState(BaseEvent event) async* {
    if (event is RegisterEvent) {
      try {
        await userRepository.signUp(
            event.username, event.password);
        print("thanhcong");
        yield state.copyWith(registerSuccess: true, registerFailure: false);
      } catch (error) {
        print("loi roi ne");
        print(error);
        yield state.copyWith(registerFailure: true, registerSuccess: false);
      }
    }
    else if (event is RegisterFailEvent) {
      yield state.copyWith(registerFailure: false);
    }
  }
}