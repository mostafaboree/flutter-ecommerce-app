import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/presentetion/Auth/login/login_cubit.dart';
import 'package:weather_app/presentetion/Auth/login/login_state.dart';

import '../../../core/widget/_buildTextField.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade500, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, AppRouter.homeRout);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  _buildAppLogo(),

                  // Welcome Text
                  _buildWelcomeText(),

                  // Username Field
                  CustomTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password Link
                  _buildForgotPasswordLink(),

                  const SizedBox(height: 20),

                  // Login Button
                  _buildLoginButton(),

                  const SizedBox(height: 20),

                  // Or Login With Text
                  _buildOrLoginWithText(),

                  const SizedBox(height: 10),

                  // Social Login Buttons
                  _buildSocialLoginButtons(),

                  const SizedBox(height: 20),

                  // Sign Up Link
                  _buildSignUpLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------- Widget Builders --------------------

  /// Builds the app logo with a Hero animation.
  Widget _buildAppLogo() {
    return const Hero(
      tag: 'logo',
      child: FlutterLogo(size: 100),
    );
  }

  /// Builds the welcome text section.
  Widget _buildWelcomeText() {
    return const  Column(
      children: [
         Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
         SizedBox(height: 10),
         Text(
          'Login to continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
         SizedBox(height: 30),
      ],
    );
  }

  /// Builds the "Forgot Password?" link.
  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to forgot password screen
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  /// Builds the login button with loading state.
  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
            if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter username and password')),
              );
            } else {
              context.read<LoginCubit>().login(
                _usernameController.text,
                _passwordController.text,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
      },
    );
  }

  /// Builds the "Or login with" text.
  Widget _buildOrLoginWithText() {
    return const Text(
      'Or login with',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  /// Builds the social login buttons (Google and Facebook).
  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Google login
          },
          icon: const Icon(Icons.g_mobiledata, size: 40),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () {
            // Facebook login
          },
          icon: const Icon(Icons.facebook, size: 40),
        ),
      ],
    );
  }

  /// Builds the "Don't have an account? Sign Up" link.
  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouter.registerRout);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}