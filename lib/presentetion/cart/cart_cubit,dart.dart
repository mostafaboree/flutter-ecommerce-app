
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/modal/cart/cart_product.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/cart/cart_entity.dart';
import 'package:weather_app/presentetion/cart/cart_state.dart';

import '../../data/modal/cart/cart.dart';


class CartCubit extends Cubit<CartState> {
  final Repo _cartRepository;

  late Cart cart;


  CartCubit(this._cartRepository) : super(CartInitial());

  // Fetch cart items
  Future<void> fetchCart() async {
    emit(CartLoading());
    final response = await _cartRepository.getCartById(5);

    print("CART response $response");

    if (response is SuccessResponse<CartEntity>) {
      cart=response.data.toCart();
      emit(CartLoaded(response.data));
    }
    else if (response is ErrorResponse) {
      emit(CartError((response as ErrorResponse).message));
    }
  }


  // Add a cart item
/*
Future<void> addCartItem(Cart cart) async {
    emit(CartLoading());
    final response = await _cartRepository.addCart(cart);

    if (response is SuccessResponse<CartEntity>) {
      final currentState = state;
      if (currentState is CartLoaded) {
        emit(CartLoaded([...currentState.cartItems, response.data]));
      }
    } else if (response is ErrorResponse) {
      emit(CartError((response as ErrorResponse).message ));
    }
  }
*/

  // Delete a cart item
  Future<void> deleteCartItem(int id) async {
    emit(CartLoading());
    final response = await _cartRepository.deleteCart(id);

    if (response is SuccessResponse) {
      final currentState = state;
      if (currentState is CartLoaded) {
        /* emit(CartLoaded(
          currentState.cartItems.where((item) => item.id != id).toList(),
        )*/


      }
    } else if (response is ErrorResponse) {
      emit(CartError(response.message));
    }
  }

// Update a cart item

  Future<void> updateCartItem( CartProduct newCart) async {
    emit(CartLoading());

//update the cart's products

    final updatedProducts= cart.products.map((product){

       if(newCart.productId==product.productId){

       return CartProduct(
           productId: product.productId,
           quantity: newCart.quantity
       );
       }
       return product;


    }).toList();
    //Update the cart object   by new Product
    cart = cart.copyWith(products: updatedProducts);


    // Send the updated cart to the repository

    final response = await _cartRepository.updateCart(5, cart);

    if (response is SuccessResponse<CartEntity>) {

        emit(CartLoaded(response.data));
      }




    else {
      emit(CartError((response as ErrorResponse).message));
    }

    }

  }



