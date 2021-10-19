import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

@immutable
class AuthenStartedEvent extends BaseEvent {
  // final FirebaseAuth firebaseAuth;
  //
  // AuthenStartedEvent(this.firebaseAuth);
}

@immutable
class AuthenLoggedInEvent extends BaseEvent {}

@immutable
class AuthenLogoutEvent extends BaseEvent {}


