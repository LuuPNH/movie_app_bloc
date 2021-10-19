import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_event.dart';
import 'package:movie_app_bloc/login_firebase/ButtonForm.dart';
import 'package:movie_app_bloc/login_firebase/login_bloc.dart';
import 'package:movie_app_bloc/login_firebase/login_event.dart';
import 'package:movie_app_bloc/login_firebase/login_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState  extends TeqWidgetState<LoginBloc, LoginWidget>
with BasePullToRefreshMixin<LoginWidget>  {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => bloc)],
        child: BlocConsumer<LoginBloc, LoginState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }
  void _handleAction(BuildContext context, LoginState state) {}

  @override
  LoginBloc createBloc() => LoginBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;

  void _onFormSubmitted() {
    bloc.add(LoginEvent(emailController.text, passwordlController.text));
  }


  Widget _buildbody(BuildContext context, LoginState state) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state.loginFailure) {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                      backgroundColor: Style.Colors.secondColor,
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Login Failure! Please again"),
                            Icon(Icons.error)
                          ])));
          }
          if(state.isLoading) {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                      backgroundColor: Style.Colors.secondColor,
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Logging In..."),
                            CircularProgressIndicator()]
                      )));
          }
          if(state.loginSuccess) {
            print("Success");
            BlocProvider.of<AuthenBloc>(context).add(AuthenLoggedInEvent());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState> (
          builder: (context, state) {
            return  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    //email
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Style.Colors.text),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Style.Colors.text),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Style.Colors.secondColor),
                          icon: Icon(EvaIcons.email, color: Style.Colors.secondColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(color: Style.Colors.secondColor, width: 1.0)
                          )
                      ),
                      autovalidate: true,
                      validator: (_) {
                        // return !state.isEmailValid! ? 'Invalid Email' : null;
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    //password
                    TextFormField(
                      controller: passwordlController,
                      style: TextStyle(color: Style.Colors.text),
                      obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Style.Colors.text),
                          labelText: 'Passowrd',
                          labelStyle: TextStyle(color: Style.Colors.secondColor),
                          icon: Icon(EvaIcons.lock, color: Style.Colors.secondColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(color: Style.Colors.secondColor, width: 1.0)
                          )
                      ),
                      autovalidate: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Passoword can't empty" ;
                        }
                        // else if(!state.isPasswordVaild!) { return 'Invalid Passoword';}
                        // return null;
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    //Button
                    ButtonForm(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      colorButton: Style.Colors.secondColor,
                      titleButton: "Login",
                      function: (){
                        _onFormSubmitted();
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),

                    ButtonForm(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      colorButton: Style.Colors.secondColor,
                      titleButton: "Register",
                      function: (){
                        // Navigator.push(context, MaterialPageRoute(
                        //     builder: (_) {
                        //       return RegisterScreen();
                        //     }) );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );

  }
}
