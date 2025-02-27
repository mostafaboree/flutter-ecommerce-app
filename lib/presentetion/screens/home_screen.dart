import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/app_router/app_router.dart';
import 'package:weather_app/data/modal/product.dart';

import '../logic/cubit/product_cubit.dart';
import '../logic/product_state.dart';
import '../widget/product_item.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    productCubit.getAllProduct();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Ecommerce App'),
          actions: [
      IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {

        // Navigate to the cart screen (we'll implement this later)
           Navigator.pushNamed(context, AppRouter.cartRout);

      },
      ), ], ),
      body: Column(
    children: [
      _buildSearchBar(context)
    ,
      Expanded(child:
      BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {


          if (state is ProductLoading) {
            return Center(child:Lottie.asset(
              'assets/lottie/loading_animation.json', // Path to your Lottie file
            ),);
          } else if (state is ProductLoaded) {

            return _buildProductGrid(state.products);


          } else if (state is ProductError) {
            return const Center(child: Text('Failed to load products'));
          }


          return const Center(child: Text('Unknown state'));
        },
      ),
    ),],),);
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (query) {
          context.read<ProductCubit>().searchProducts(query);
        },
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(product:products[index]),
    );
  }
}