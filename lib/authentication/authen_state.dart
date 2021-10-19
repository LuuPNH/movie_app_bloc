import 'package:firebase_auth/firebase_auth.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class AuthenState extends BaseState {
  final error;
  final bool isLoading;
  final bool authenSuccess;
  final bool authenFailure;
  final FirebaseAuth? firebaseAuth;

  @override
  List<Object?> get props =>
      [error, isLoading, authenSuccess, authenFailure, firebaseAuth];

  AuthenState(
      {this.isLoading = false,
      this.error,
      this.authenSuccess = false,
      this.authenFailure = false,
      this.firebaseAuth});

  AuthenState copyWith(
          {bool? isLoading,
          var error,
          bool? authenSuccess,
          bool? authenFailure,
          FirebaseAuth? firebaseAuth}) =>
      AuthenState(
          isLoading: isLoading ?? false,
          error: error,
          authenSuccess: authenSuccess ?? this.authenSuccess,
          authenFailure: authenFailure ?? this.authenFailure,
          firebaseAuth: firebaseAuth ?? this.firebaseAuth);
}
