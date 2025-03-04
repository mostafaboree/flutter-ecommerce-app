import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/data/modal/product/product.dart';
import 'package:weather_app/presentetion/product/screens/widget/special_offer_widget.dart';

import '../../logic/cubit/product_cubit.dart';
import '../../logic/product_state.dart';
import 'widget/product_item.dart';



class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey cartIconKey = GlobalKey(); // Key for the cart icon

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    productCubit.getAllProduct();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ecommerce App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            key: cartIconKey, // Assign the key to the cart icon
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.cartRout);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
        const SpecialOfferWidget(),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_animation.json',
                      width: 150,
                      height: 150,
                    ),
                  );
                } else if (state is ProductLoaded) {
                  return _buildProductGrid(state.products);
                } else if (state is ProductError) {
                  return Center(
                    child: Text(
                      'Failed to load products',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[600],
                      ),
                    ),
                  );
                }
                return const Center(child: Text('Unknown state'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(
        product: products[index],
        cartIconKey: cartIconKey, // Pass the key to ProductItem
      ),
    );
  }




  // Special Offer Widget for Home Screen

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onChanged: (query) {
          context.read<ProductCubit>().searchProducts(query);
        },
      ),
    );
  }

  /// Product Grid Widget for Home Screen

}