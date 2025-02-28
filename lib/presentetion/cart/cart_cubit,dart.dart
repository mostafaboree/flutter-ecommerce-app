import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/cart/cart_entity.dart';
import 'package:weather_app/presentetion/cart/cart_state.dart';

import '../../data/modal/cart/cart.dart';


class CartCubit extends Cubit<CartState> {
  final Repo _cartRepository;


  CartCubit(this._cartRepository) : super(CartInitial());

  // Fetch cart items
  Future<void> fetchCart() async {
    emit(CartLoading());
    final response = await _cartRepository.getCartById(5);

    print("CART response $response");

    if (response is SuccessResponse<CartEntity>) {
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
/* Future<void> updateCartItem(int id, Cart cart) async {
    emit(CartLoading());
    final response = await _cartRepository.updateCart(id, cart);

    if (response is SuccessResponse<Cart>) {
      final currentState = state;
      if (currentState is CartLoaded) {
        final updatedItems = currentState.cartItems.product.map((item) {
          return item.product.id  == cart.products  ) ? response.data : item;
        }).toList();
        emit(CartLoaded(updatedItems));
      }
    } else if (response is ErrorResponse) {
      emit(CartError((response as ErrorResponse).message ));
    }
  }
}*/
}
