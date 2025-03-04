import 'package:flutter/material.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      height: 150,
      decoration: _buildBoxDecoration(),
      child: Row(
        children: [
          _buildOfferIcon(),
          const SizedBox(width: 16),
          _buildOfferText(),
          const Spacer(),
          _buildViewAllButton(),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image: Image.asset('assets/images/sale.jpg').image,
        fit: BoxFit.cover,
        colorFilter: const ColorFilter.mode(
          Colors.transparent,
          BlendMode.darken,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildOfferIcon() {
    return const Icon(
      Icons.local_offer,
      size: 40,
      color: Colors.white,
    );
  }

  Widget _buildOfferText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '50% SPECIAL',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Limited time offer!',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }


  ///
  Widget _buildViewAllButton() {
    return TextButton(
      onPressed: () {
        // Navigate to special offers
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'View All',
        style: TextStyle(
          color: Colors.orange[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}