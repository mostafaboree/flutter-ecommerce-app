import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/data/modal/user/user.dart';
import '../../../data/modal/user/Address.dart';
import '../../../data/modal/user/Geolocation.dart';
import '../../../data/modal/user/name.dart';
import 'registration_cubit.dart';
import 'registration_state.dart';

class RegistrationScreen extends StatelessWidget {
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
          icon: Icon(Icons.close, color: Colors.white),
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo with Hero Animation
                  Hero(
                    tag: 'logo',
                    child: FlutterLogo(size: 100),
                  ),
                  SizedBox(height: 20),

                  // Registration Title
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

                  // Email Field
                  _buildTextField(_emailController, 'Email', Icons.email),
                  SizedBox(height: 16),

                  // Username Field
                  _buildTextField(_usernameController, 'Username', Icons.person),
                  SizedBox(height: 16),

                  // Password Field
                  _buildTextField(_passwordController, 'Password', Icons.lock, isPassword: true),
                  SizedBox(height: 16),

                  // First Name Field
                  _buildTextField(_firstNameController, 'First Name', Icons.person_outline),
                  SizedBox(height: 16),

                  // Last Name Field
                  _buildTextField(_lastNameController, 'Last Name', Icons.person_outline),
                  SizedBox(height: 16),

                  // City Field
                  _buildTextField(_cityController, 'City', Icons.location_city),
                  SizedBox(height: 16),

                  // Street Field
                  _buildTextField(_streetController, 'Street', Icons.add_road),
                  SizedBox(height: 16),

                  // Number Field
                  _buildTextField(_numberController, 'Number', Icons.format_list_numbered),
                  SizedBox(height: 16),

                  // Zipcode Field
                  _buildTextField(_zipcodeController, 'Zipcode', Icons.map),
                  SizedBox(height: 16),

                  // Phone Field
                  _buildTextField(_phoneController, 'Phone', Icons.phone),
                  SizedBox(height: 20),

                  // Register Button
                  BlocBuilder<RegistrationCubit, RegistrationState>(
                    builder: (context, state) {
                      if (state is RegistrationLoading) {
                        return CircularProgressIndicator(color: Colors.white);
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_validateFields()) {
                            context.read<RegistrationCubit>().register(
                              User(
                                email: _emailController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                                name: Name(
                                  firstname: _firstNameController.text,
                                  lastname: _lastNameController.text,
                                ),
                                address: Address(
                                  city: _cityController.text,
                                  street: _streetController.text,
                                  number: int.parse(_numberController.text),
                                  zipcode: _zipcodeController.text,
                                  geolocation: Geolocation(lat: '', long: ''),
                                ),
                                phone: _phoneController.text,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Already Have an Account Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: isPassword,
    );
  }

  bool _validateFields() {
    return _emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _numberController.text.isNotEmpty &&
        _zipcodeController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
  }
}