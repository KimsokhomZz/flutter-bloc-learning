part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String uid;

  AuthSuccessState({required this.uid});
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({this.errorMessage = 'An error occurred. Please try again.'});
}
