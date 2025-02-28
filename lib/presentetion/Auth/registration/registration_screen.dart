
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/data/modal/user/user.dart';
import 'package:weather_app/data/modal/user/address.dart';
import 'package:weather_app/data/modal/user/geolocation.dart';
import 'package:weather_app/data/modal/user/name.dart';
import 'registration_cubit.dart';
import 'registration_state.dart';

class RegistrationScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.purple.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is RegistrationSuccess) {
              Navigator.pushReplacementNamed(context, AppRouter.homeRout);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo with Hero Animation
                    const Hero(
                      tag: 'logo',
                      child: FlutterLogo(size: 100),
                    ),
                    const SizedBox(height: 20),

                    // Registration Title
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Join us to start shopping',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    _buildTextField(_emailController, 'Email', Icons.email),
                    const SizedBox(height: 16),

                    // Username Field
                    _buildTextField(_usernameController, 'Username', Icons.person),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildTextField(_passwordController, 'Password', Icons.lock, isPassword: true),
                    const SizedBox(height: 16),

                    // First Name Field
                    _buildTextField(_firstNameController, 'First Name', Icons.person_outline),
                    const SizedBox(height: 16),

                    // Last Name Field
                    _buildTextField(_lastNameController, 'Last Name', Icons.person_outline),
                    const SizedBox(height: 16),

                    // City Field
                    _buildTextField(_cityController, 'City', Icons.location_city),
                    const SizedBox(height: 16),

                    // Street Field
                    _buildTextField(_streetController, 'Street', Icons.add_road),
                    const SizedBox(height: 16),

                    // Number Field
                    _buildTextField(_numberController, 'Number', Icons.format_list_numbered),
                    const SizedBox(height: 16),

                    // Zipcode Field
                    _buildTextField(_zipcodeController, 'Zipcode', Icons.map),
                    const SizedBox(height: 16),

                    // Phone Field
                    _buildTextField(_phoneController, 'Phone', Icons.phone),
                    const SizedBox(height: 20),

                    // Register Button
                    BlocBuilder<RegistrationCubit, RegistrationState>(
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
                    ),
                    const SizedBox(height: 20),

                    // Already Have an Account Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}