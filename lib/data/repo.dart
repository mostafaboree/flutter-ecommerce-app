import 'package:weather_app/data/modal/cart/cart.dart';
import 'package:weather_app/data/modal/cart/cart_product.dart';
import 'package:weather_app/data/modal/product/product.dart';
import 'package:weather_app/data/modal/user/user_login.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/remote/api_service.dart';
import 'package:weather_app/presentetion/cart/cart_entity.dart';

import 'modal/user/address.dart';
import 'modal/user/geolocation.dart';
import 'modal/user/name.dart';
import 'modal/user/user.dart';

class Repo {
  // Create an instance of ApiService
  ApiService apiService;

  Repo(this.apiService);
  // ****************************************** Product Features ********************************** //

// Get all product function
  Future<ApiResponse<List<ProductModel>>> getAllProduct() async {
    var response = await apiService.getProducts();
    try {
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  /// Fetches a product by its ID
   Future<ApiResponse<ProductModel>> getProduct(int id) async {
    try {
      final response = await apiService.getProductById(id);
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }


  //    ******************************************  user Auth feature ********************************** //

   /// Logs in a user with the provided email and password
  Future<ApiResponse<String>> login(String email, String password) async {
    try {
      final response = await apiService.login(
          UserLogin(username: email, password: password));
      return SuccessResponse(response.token);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }


  /// Registers a new user.
  Future<ApiResponse<User>> register({
    required String email,
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String address,
    required String phone,
  }) async {
    try {
      final user = User(
        email: email,
        username: username,
        password: password,
        name: Name(firstname: firstname, lastname: lastname),
        address: Address(
          city: address,
          street: 'N/A', // Replace with actual data if available
          zipcode: 'N/A',
          number: 0,
          geolocation: Geolocation(lat: '0', long: '0'),
        ),
        phone: phone,
      );

      final response = await apiService.register(user);
      return SuccessResponse(response);
    } catch (e) {
      print("Error: ${e.toString()}");
      return ErrorResponse(e.toString());
    }
  }

  //    ******************************************   Cart Features ********************************** //

  // Get cart function
  Future<ApiResponse<CartEntity>> getCartById(int id) async {
    try {
      final cartResponse = await apiService.getCartById(id);
      final productsWithDetails = await _fetchProductDetailsForCart(cartResponse.products);
      final cartEntity = CartEntity(
        id: cartResponse.id,
        userId: cartResponse.userId,
        date: cartResponse.date,
        product: productsWithDetails,
      );
      return SuccessResponse(cartEntity);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  /// Adds a new cart.
  Future<ApiResponse<Cart>> addCart(Cart cart) async {
    try {
      final response = await apiService.addCart(cart);
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  /// Deletes a cart by its ID.
  Future<ApiResponse<void>> deleteCart(int id) async {
    try {
      await apiService.deleteCart(id);
      return SuccessResponse(null);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  /// Updates a cart by its ID. and  return update cart
  Future<ApiResponse<CartEntity>> updateCart(int id, Cart cart) async {
    try {
      final cartResponse= await apiService.updateCart(id, cart);
      final productsWithDetails = await _fetchProductDetailsForCart(cartResponse.products);
      final cartEntity = CartEntity(
        id: cartResponse.id,
        userId: cartResponse.userId,
        date: cartResponse.date,
        product: productsWithDetails,
      );
      return SuccessResponse(cartEntity);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  // ****************************************** Helper Methods ********************************** //

  /// Fetches product details for a list of cart products.
  Future<List<CartProductWithDetails>> _fetchProductDetailsForCart(
      List<CartProduct> cartProducts,
      ) async {
    return await Future.wait(
      cartProducts.map((cartProduct) async {
        final product = await apiService.getProductById(cartProduct.productId);
        return CartProductWithDetails(
          quantity: cartProduct.quantity,
          product: product,
        );
      }),
    );
  }

  /// Enriches a list of carts with product details.
  Future<List<CartEntity>> _enrichCartWithProductDetails(List<Cart> carts) async {
    return await Future.wait(
      carts.map((cart) async {
        final productsWithDetails = await _fetchProductDetailsForCart(cart.products);
        return CartEntity(
          id: cart.id,
          userId: cart.userId,
          date: cart.date,
          product: productsWithDetails,
        );
      }),
    );
  }
}






