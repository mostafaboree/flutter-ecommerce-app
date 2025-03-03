import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/sheradprefernc.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      lottieAsset: 'assets/lottie/welcome.json',
      title: 'Welcome to Our Store',
      description: 'Explore a wide range of products and enjoy a seamless shopping experience.',
    ),
    OnboardingItem(
      lottieAsset: 'assets/lottie/shopping_cart.json',
      title: 'Easy Shopping',
      description: 'Add products to your cart and checkout with just a few taps.',
    ),
    OnboardingItem(
      lottieAsset: 'assets/lottie/delivery.json',
      title: 'Fast Delivery',
      description: 'Get your orders delivered quickly and securely to your doorstep.',
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.purple.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // PageView for Onboarding Screens
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                item: _onboardingItems[index],
              );
            },
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Progress Bar
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _onboardingItems.length,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),

          // Next/Get Started Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _currentPage == _onboardingItems.length - 1 ? double.infinity : 150,
              child: ElevatedButton(
                onPressed: () async {
                  if (_currentPage == _onboardingItems.length - 1) {
                    // Navigate to the next screen (e.g., login or home)
                    // Save onboarding completion state
                    await SharedPreferencesHelper.setOnboardingCompleted(true);

                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _currentPage == _onboardingItems.length - 1 ? 'Get Started' : 'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          GestureDetector(
            onTap: () {
              // Play animation on tap
              Lottie.asset(item.lottieAsset).repeat;
            },
            child: Lottie.asset(
              item.lottieAsset,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),

          // Title
          Text(
            item.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),

          // Description
          Text(
            item.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String lottieAsset;
  final String title;
  final String description;

  OnboardingItem({
    required this.lottieAsset,
    required this.title,
    required this.description,
  });
}