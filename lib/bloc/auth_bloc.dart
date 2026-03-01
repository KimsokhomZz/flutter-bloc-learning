import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginRequested>((event, emit) async {
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

        await Future.delayed(Duration(seconds: 2), () {
          return emit(AuthSuccessState(uid: '$email-$password'));
        });
      } catch (e) {
        return emit(AuthErrorState(errorMessage: e.toString()));
      }
    });
  }
}
