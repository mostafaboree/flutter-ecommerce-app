import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/modal/product/product.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/domin/product_repository.dart';

import 'core/app_router/app_router.dart';
import 'core/sheradprefernc.dart';
import 'data/remote/api_service.dart';
import 'data/repo.dart';
import 'presentetion/logic/cubit/product_cubit.dart';

void main() async {
// Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

// Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

// Check onboarding and authentication state
  final isOnboardingCompleted = await SharedPreferencesHelper
      .isOnboardingCompleted();
  final isAuthenticated = await SharedPreferencesHelper.isAuthenticated();

// Determine the initial route
  String initialRoute;
  if (!isOnboardingCompleted) {
    initialRoute =
        AppRouter.onBoardingRoute; // Show onboarding if not completed
  } else if (isAuthenticated) {
    initialRoute = AppRouter.homeRout; // Show home if authenticated
  } else {
    initialRoute = AppRouter
        .loginRout; // Show login if onboarding is completed but not authenticated
  }

// Run the app
  runApp(
    MaterialApp(
      title: 'Ecommerce',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      // Use AppRouter for navigation
      initialRoute: initialRoute, // Set the initial route based on user state
    ),
  );
}