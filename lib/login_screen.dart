import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_bloc/bloc/auth_bloc.dart';
import 'package:learning_flutter_bloc/home_screen.dart';
import 'package:learning_flutter_bloc/widgets/gradient_btn.dart';
import 'package:learning_flutter_bloc/widgets/login_field.dart';
import 'package:learning_flutter_bloc/widgets/social_btn.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Throttler _throttler = Throttler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener:
            (context, state) => {
              // login failed
              if (state is AuthErrorState)
                {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage))),
                },
              // login success
              if (state is AuthSuccessState)
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),
                },
            },

        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/background.png'),
                Text(
                  'Sign in.',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                SocialButton(
                  label: 'Continue with Google',
                  iconPath: 'assets/svgs/g_logo.svg',
                ),
                const SizedBox(height: 18),
                SocialButton(
                  label: 'Continue with Facebook',
                  iconPath: 'assets/svgs/f_logo.svg',
                  horizontalPadding: 90.0,
                ),
                const SizedBox(height: 14),
                Text('or', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 14),
                LoginField(controller: _emailController, hintText: 'Email'),
                const SizedBox(height: 14),
                LoginField(
                  controller: _passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 18),
                GradientButton(
                  onPressed: () {
                    _throttler.throttle(
                      duration: const Duration(seconds: 1),
                      onThrottle: () {
                        print('😛 Sign in pressed at: ${DateTime.now()}');
                        context.read<AuthBloc>().add(
                          AuthLoginRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Sign in',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _throttler.cancel();
    super.dispose();
  }
}
