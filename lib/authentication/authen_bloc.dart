import 'package:movie_app_bloc/authentication/authen_event.dart';
import 'package:movie_app_bloc/authentication/authen_state.dart';
import 'package:movie_app_bloc/repository/user_repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class AuthenBloc extends BaseBloc<AuthenState> {
  UserRepository userRepository = UserRepository();

  AuthenBloc() : super(AuthenState(isLoading: true));

  @override
  Stream<AuthenState> mapEventToState(BaseEvent event) async* {
    if (event is AuthenStartedEvent) {
      var isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        var firebaseUser = await userRepository.getUser();
        yield state.copyWith(firebaseAuth: firebaseUser, authenSuccess: true);
      } else {
        yield state.copyWith(authenFailure: true);
      }
    } else if (event is AuthenLoggedInEvent) {
      yield state.copyWith(
          firebaseAuth: await userRepository.getUser(),
          authenSuccess: true,
          authenFailure: false);
    } else if (event is AuthenLogoutEvent) {
      await userRepository.signOut();
      yield state.copyWith(authenFailure: true);
    }
  }
}
