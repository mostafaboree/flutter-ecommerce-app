import 'package:flutter/material.dart';

class AnimatedIconToCart extends StatefulWidget {
  final Offset startOffset;
  final Offset endOffset;
  final VoidCallback onAnimationComplete;
  final String imageUrl; // Add this parameter for the product image

  const AnimatedIconToCart({super.key,
    required this.startOffset,
    required this.endOffset,
    required this.onAnimationComplete,
    required this.imageUrl, // Pass the product image URL
  });

  @override
  _AnimatedIconToCartState createState() => _AnimatedIconToCartState();
}





class _AnimatedIconToCartState extends State<AnimatedIconToCart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: widget.startOffset,
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) {
      widget.onAnimationComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12), // Optional: Add rounded corners
            child: Image.network(
              widget.imageUrl, // Use the product image URL
              width: 50, // Adjust the size as needed
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}