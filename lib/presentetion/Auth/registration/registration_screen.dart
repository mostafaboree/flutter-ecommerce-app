import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/core/widget/WavePainter.dart';
import 'package:weather_app/core/widget/_buildTextField.dart';

import '../../../data/modal/user/name.dart';
import '../../../data/modal/user/user.dart';
import 'registration_cubit.dart';
import 'registration_state.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _showAdditionalFields = false; // To toggle additional fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,

      body: Stack(
        children: [

          // Wave Header custom view
          _buildWaveHeader(),

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100), // Space for the wave

                  // App Logo with Hero Animation
                  const Hero(
                    tag: 'logo',
                    child: FlutterLogo(size: 100),
                  ),
                  const SizedBox(height: 20),

                  // Registration  title & subtitle
                  _buildRegistrationTitle(),

                  const SizedBox(height: 30),

                  // Email Field
                  CustomTextField(controller: _emailController,label:  'Email', icon:Icons.email),
                  const SizedBox(height: 16),

                  // Username Field
                  CustomTextField(controller: _usernameController, label: 'Username', icon:Icons.person),
                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextField(controller: _passwordController, label: 'Password', icon:Icons.lock, isPassword: true),
                  const SizedBox(height: 16),

                  // Toggle Additional Fields
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAdditionalFields = !_showAdditionalFields;
                      });
                    },
                    child: Text(
                      _showAdditionalFields ? 'Hide Additional data' : 'Complete your data ',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Additional Fields (Expanded Section)
                  if (_showAdditionalFields) _buildAdditionalFields(),


                  // Register Button
                  _buildRegisterButton(),

                  const SizedBox(height: 20),

                  // Already Have an Account Link
                  _buildLoginLink()

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///***********************************   build widget or component of reg screen   ************************

  /// widget  the registration title and subtitle.
  Widget _buildRegistrationTitle() {
    return const Column(
        children: [
          Text(
            'Create an Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Join us to start shopping',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 30),
        ],
    );
  }

  /// Builds the wave header at the top of the screen.
  Widget _buildWaveHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 400,
        child: CustomPaint(
          painter: WavePainter(),
        ),
      ),
    );
  }

  /// Builds the additional fields section. for more user detalise
  Widget _buildAdditionalFields() {
    return Column(
      children: [
          CustomTextField(controller:  _firstNameController, label: 'First Name', icon:Icons.person_outline),
          const SizedBox(height: 16),
          CustomTextField(controller: _lastNameController,label:  'Last Name', icon:Icons.person_outline),
          const SizedBox(height: 16),
          CustomTextField(controller: _cityController, label: 'City',icon: Icons.location_city),
          const SizedBox(height: 16),
          CustomTextField(controller: _streetController, label: 'Street',icon:  Icons.add_road),
          const SizedBox(height: 16),
          CustomTextField(controller: _numberController, label: 'Number', icon:Icons.format_list_numbered),
          const SizedBox(height: 16),
          CustomTextField(controller: _zipcodeController,label:  'Zipcode',icon: Icons.map),
          const SizedBox(height: 16),
          CustomTextField (controller: _phoneController, label: 'Phone',icon:  Icons.phone),
          const SizedBox(height: 20),

      ],
    );
  }
  /// Builds the register button with loading state.
  Widget _buildRegisterButton() {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is RegistrationLoading) {
          return const CircularProgressIndicator(color: Colors.white);
        }
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<RegistrationCubit>().register(
                User(
                  email: _emailController.text,
                  username: _usernameController.text,
                  password: _passwordController.text,
                  name: Name(
                    firstname: _firstNameController.text,
                    lastname: _lastNameController.text,
                  ),
                  phone: _phoneController.text,
                ),
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
            'Register',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
      },
    );
  }


  /// Builds the "Already have an account?" login link.
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w700,fontSize: 23),
          ),
        ),
      ],
    );
  }


}