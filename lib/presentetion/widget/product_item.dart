import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/data/modal/product.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data/modal/product.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({
    super.key,
    required this.product,
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
                    if (loadingProgress == null) return child; // Image is fully loaded
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_animation.json', // Path to your Lottie file
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
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Favorite Button
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          // Toggle favorite state
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
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          // Add to cart
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to cart'),
                              backgroundColor: Colors.green,
                            ),
                          );
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
}






