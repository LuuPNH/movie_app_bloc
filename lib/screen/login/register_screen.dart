import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_bloc/login_firebase/SignIn/login_widget.dart';
import 'package:movie_app_bloc/login_firebase/resgiter/register_widget.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;
import 'package:movie_app_bloc/login_firebase/CurvedWidget.dart';

class RegisterScreen extends StatelessWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    EvaIcons.arrowBack,
                    color:  Style.Colors.btnColor,
                  ));
            },
          ),
          title: Text("Movie App")),
      body: SingleChildScrollView(
          child: Stack(
              children: [
                CurvedWidget(
                  curvedHeight: 80.0,
                  curvedDistance: 80.0,
                  child: Container(
                    padding: EdgeInsets.only(top: 70.0, left: 50.0),
                    width: double.infinity,
                    height: 270.0,
                    color: Style.Colors.secondColor,
                    child:Text("Register", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ), ),
                Container(
                  margin: const EdgeInsets.only(top: 200.0),
                  child: RegisterWidget(),
                )
              ]),
        ),
    );
  }
}