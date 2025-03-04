import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data/modal/product/product.dart';

import 'animated_product_to_icon_cart.dart';




class ProductItem extends StatelessWidget {
  final ProductModel product;
  final GlobalKey cartIconKey;

  const ProductItem({
    super.key,
    required this.product,
    required this.cartIconKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child:Container(

        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(16),
          ),
        ),

      child: Column(
        children: [
          // Card with product image and special offer tag
          Card(

            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 200, // Adjust height as needed
                child: Stack(
                  children: [
                    _buildProductImage(),
                    _buildSpecialOfferTag(), // Special offer tag on top of the image
                  ],
                ),
              ),
            ),
          ),

          // Footer overlay under the card
          Expanded(child:
          _buildFooterOverlay(context),),
        ],
      ),),
    );
  }

  Widget _buildProductImage() {
    return Hero(
      tag: 'product-image-${product.id}',
      child: Image.network(
        product.image,
        fit: BoxFit.fill,
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
    );
  }



//******************************************* widget of product item *****************************************
  Widget _buildSpecialOfferTag() {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          '50% OFF',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFooterOverlay(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient:  LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white,
              Colors.white70,
            ],
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
             Flexible(child:  Column(
               mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildProductTitle(),
                _buildCartButton(context),
            ]
            ),),
_buildFavoriteButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite_border),

      color: Colors.black,
      onPressed: () => _showSnackBar('Added to favorites',context),
    );
  }

  Widget _buildProductTitle() {
    return  Text(
        product.title.substring(0,10),
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

    );
  }

  Widget _buildCartButton(BuildContext context) {

    return Text(
      " ${product.price} ",
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.pinkAccent,
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(context, '/details', arguments: product);
  }

  void _showSnackBar(String message,BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.pink,
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



