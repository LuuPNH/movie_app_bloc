import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_event.dart';
import 'package:movie_app_bloc/authentication/authen_state.dart';
import 'package:movie_app_bloc/screen/home/login_screen.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class AuthenWidget extends StatefulWidget {
  const AuthenWidget({Key? key}) : super(key: key);

  @override
  _AuthenWidgetState createState() => _AuthenWidgetState();
}

class _AuthenWidgetState extends TeqWidgetState<AuthenBloc, AuthenWidget>
    with BasePullToRefreshMixin<AuthenWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => bloc..add(AuthenStartedEvent()))
        ],
        child: BlocConsumer<AuthenBloc, AuthenState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  void _handleAction(BuildContext context, AuthenState state) {}

  @override
  AuthenBloc createBloc() => AuthenBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;

  Widget _buildbody(BuildContext context, AuthenState state) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthenBloc, AuthenState>(builder: (context, state) {
      if (state.authenFailure) {
        return LoginScreen();
      } else if (state.authenSuccess) {
        return Container(
          color: Colors.green,
          child: Center(
              child: IconButton(
                  icon: Icon(Icons.air),
                  onPressed: () {
                    BlocProvider.of<AuthenBloc>(context)
                        .add(AuthenLogoutEvent());
                  })),
        );
      } else {
        return Container(color: Colors.yellow);
      }
    });
  }
}
