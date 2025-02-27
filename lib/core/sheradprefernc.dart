import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _isOnboardingCompletedKey = 'isOnboardingCompleted';
  static const String _isAuthenticatedKey = 'isAuthenticated';

  // Save onboarding completion state
  static Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isOnboardingCompletedKey, value);
  }

  // Get onboarding completion state
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isOnboardingCompletedKey) ?? false;
  }

  // Save authentication state
  static Future<void> setAuthenticated(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAuthenticatedKey, token.isNotEmpty);
  }

  // Get authentication state
  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isAuthenticatedKey) ?? false;
  }

  // Clear all preferences (e.g., on logout)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}