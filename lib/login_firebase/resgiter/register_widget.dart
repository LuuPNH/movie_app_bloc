import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/login_firebase/ButtonForm.dart';
import 'package:movie_app_bloc/login_firebase/resgiter/register_bloc.dart';
import 'package:movie_app_bloc/login_firebase/resgiter/register_event.dart';
import 'package:movie_app_bloc/login_firebase/resgiter/register_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState  extends TeqWidgetState<RegisterBloc, RegisterWidget>
    with BasePullToRefreshMixin<RegisterWidget>  {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => bloc)],
        child: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }
  void _handleAction(BuildContext context, RegisterState state) {}

  @override
  RegisterBloc createBloc() => RegisterBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;

  void _onFormSubmitted() {
    bloc.add(RegisterEvent(emailController.text, passwordlController.text));
  }

  bool validateEmail() {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(emailController.text) || emailController.text.isEmpty)
      return false;
    else
      return true;
  }
  Widget _buildbody(BuildContext context, RegisterState state) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if(state.registerFailure) {
            bloc.add(RegisterFailEvent());
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                      backgroundColor: Style.Colors.secondColor,
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Register Failure! Please again"),
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
                            Text("Registering..."),
                            CircularProgressIndicator()]
                      )));
          }
          if(state.registerSuccess) {
            print("Success");
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                      backgroundColor: Style.Colors.secondColor,
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sign Up Success"),
                            CircularProgressIndicator()]
                      )));
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState> (
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(validateEmail()) {
                          return null;
                        } else return "Enter a valid email address";
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid email address" ;
                        }
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
                      titleButton: "Register",
                      function: (){
                        _onFormSubmitted();
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have a account?", style: TextStyle(color: Style.Colors.text)),
                        TextButton(
                          onPressed: () { Navigator.pop(context);},
                          child: const Text('Singin', style: TextStyle(color: Style.Colors.secondColor)),
                        ),
                      ],
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