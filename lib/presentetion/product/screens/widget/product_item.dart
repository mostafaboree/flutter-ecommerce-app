import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data/modal/product/product.dart';



class ProductItem extends StatelessWidget {
  final ProductModel product;
  final GlobalKey cartIconKey; // Key to locate the cart icon in the app bar

  const ProductItem({
    super.key,
    required this.product,
    required this.cartIconKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: product,
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Product Image with Hero Animation
              Hero(
                tag: 'product-image-${product.id}',
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_animation.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              ),

              // Gradient Overlay for Footer
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Favorite Button
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to favorites'),
                              backgroundColor: Colors.pink,
                            ),
                          );
                        },
                      ),

                      // Product Title
                      Expanded(
                        child: Text(
                          product.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Shopping Cart Button
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () {
                          _animateToCart(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _animateToCart(BuildContext context) {

    //Start Position: The position of the cart icon in the ProductItem **********************

    // Get the position of the cart icon in the ProductItem
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset startOffset = renderBox.localToGlobal(Offset.zero);
    // late   OverlayEntry overlayEntry;
    late OverlayEntry overlayEntry;


    // Get the position of the cart icon in the app bar &&
    // End Position: The position of the cart icon in the app bar.
    final RenderBox cartIconRenderBox = cartIconKey.currentContext!.findRenderObject() as RenderBox;

    //converts the local position of the widget to the global position on the screen.
    final Offset endOffset = cartIconRenderBox.localToGlobal(Offset.zero);

    // Create an OverlayEntry for the animation
     overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedIconToCart(
          startOffset: startOffset,  //position of product item
          endOffset: endOffset,     // position of cartIcon of app bar
          onAnimationComplete: () {
            // Remove the overlay after the animation completes
            overlayEntry.remove();
          },
          imageUrl: product.image, // Pass the product image URL
        );
      },
    );

    // Insert the overlay into the Overlay
    Overlay.of(context).insert(overlayEntry);
  }}



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