import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/modal/cart/cart_product.dart';
import 'cart_cubit,dart.dart';
import 'cart_entity.dart';
import 'cart_state.dart';




class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch cart details when the screen loads
    context.read<CartCubit>().fetchCart();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else if (state is CartLoaded) {
            final cart = state.cartItems; // Single CartEntity
            if (cart.product.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: cart.product.length,
                    itemBuilder: (context, index) {
                      final cartProduct = cart.product[index];
                      return _buildProductCard(cartProduct, context, cart.id);
                    },
                  ),
                ),
                _buildCheckoutSection(cart, context),
              ],
            );
          } else {
            return Center(child: Text('Your cart is empty'));
          }
        },
      ),
    );
  }

  // Build a modern product card with image, title, price, and quantity controls
  Widget _buildProductCard(CartProductWithDetails cartProduct, BuildContext context, int cartId) {
    return Dismissible(
      key: Key(cartProduct.product.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        // Remove item from cart
      //  context.read<CartCubit>().deleteCartItem(cartId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${cartProduct.product.title} removed from cart'),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(cartProduct.product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.product.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${cartProduct.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.red),
                          onPressed: () {
                            // Decrease quantity
                            context.read<CartCubit>().updateCartItem(

                              CartProduct(
                                productId: cartProduct.product.id,
                                quantity: cartProduct.quantity - 1,
                              ),
                            );
                          },
                        ),
                        Text(
                          '${cartProduct.quantity}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                        // Increase quantity
                          context.read<CartCubit>().updateCartItem(
                              CartProduct(
                                productId: cartProduct.product.id,
                                quantity: cartProduct.quantity + 1,
                              ),
                          );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build a modern checkout section with total price and checkout button
  Widget _buildCheckoutSection(CartEntity cart, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              Spacer(),
              Text(
                '\$${_calculateTotal(cart).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to checkout screen
              Navigator.pushNamed(context, '/checkout');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Calculate the total price of all items in the cart
  double _calculateTotal(CartEntity cart) {
    double total = 0;
    for (final product in cart.product) {
      total += product.product.price * product.quantity;
    }
    return total;
  }
}