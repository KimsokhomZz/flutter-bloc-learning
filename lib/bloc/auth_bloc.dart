import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   print(change);
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   print(transition);
  // }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final email = event.email;
      final password = event.password;

      // email validation
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(AuthErrorState(errorMessage: 'Invalid email address.'));
        return;
      }

      // password validation
      if (password.length < 6) {
        emit(
          AuthErrorState(
            errorMessage: 'Password must be at least 6 characters long.',
          ),
        );
        return;
      }

      await Future.delayed(Duration(milliseconds: 1500), () {
        return emit(AuthSuccessState(uid: '$email-$password'));
      });
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
      return;
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await Future.delayed(Duration(milliseconds: 1500), () {
      return emit(AuthInitialState());
    });
  }
}
