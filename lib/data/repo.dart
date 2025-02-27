import 'package:weather_app/data/modal/cart/cart.dart';
import 'package:weather_app/data/modal/cart/cart_product.dart';
import 'package:weather_app/data/modal/product.dart';
import 'package:weather_app/data/modal/user/user_login.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/remote/api_service.dart';
import 'package:weather_app/presentetion/cart/cart_entity.dart';

import 'modal/user/Address.dart';
import 'modal/user/Geolocation.dart';
import 'modal/user/name.dart';
import 'modal/user/user.dart';

class Repo {
  // Create an instance of ApiService
  ApiService apiService;

  Repo(this.apiService);

// Get all product function
  Future<ApiResponse<List<ProductModel>>> getAllProduct() async {
    var response = await apiService.getProducts();
    try {
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

// Get product by id function
  Future<ApiResponse<ProductModel>> getProduct(int id) async {
    try {
      final response = await apiService.getProduct(id);
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }


  //    ******************************************  user Auth feature ********************************** //

  // User login function
  Future<ApiResponse<String>> login(String email, String password) async {
    try {
      final response = await apiService.login(
          UserLogin(username: email, password: password));
      return SuccessResponse(response.token);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  // User registration function
  Future<ApiResponse<User>> register(String email, String username,
      String password, String firstname, String lastname, String address,
      String phone) async {
    try {
      final response = await apiService.register(User(
        email: "Mostafa@gmail.com",
        username: "mostafa",
        password: "123456",
        name: const Name(firstname: "mostafa", lastname: "sayed"),
        address: const Address(city: 'gjhj',
            street: 'gg',
            zipcode: '41',
            number: 54,
            geolocation: Geolocation(lat: '23333333', long: '44443')),
        phone: "01000000000",
      ));
      return SuccessResponse(response);
    } catch (e) {
      print("Error: ${e.toString()}");
      return ErrorResponse(e.toString());
    }
  }

  //    ******************************************  user cart feature ********************************** //

  // Get cart function
  Future<ApiResponse<List<CartEntity>>> getCart() async {
    try {
      // Fetch the cart
      final cartResponse = await apiService.getCart();
      print(" Cart Response  repo ${cartResponse}" );

      // Fetch product details for each product in the cart
      final cartsWithProducts = await Future.wait(
        cartResponse.map((cart) async {

          // Fetch product details for each product in the cart*****************************
          final productsWithDetails = await Future.wait(
            cart.products.map((cartProduct) async {
              // Fetch the full product details using the productId
              final product = await apiService.getProduct(cartProduct.productId);
              // Return a new object combining cart product and product details

              return  CartProductWithDetails(
                quantity: cartProduct.quantity,
                product: product,
              );
            }),
          );

          // Step 3: Create a new CartEntity with product details

          return CartEntity(
            id: cart.id,
            userId: cart.userId,
            date: cart.date,
            product: productsWithDetails,

          );
        }),
      );

      return SuccessResponse(cartsWithProducts);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }
  
  Future<ApiResponse<CartEntity>> getCartById( int id) async {

    try {
      final response = await apiService.getCartById(id);
      final productsWithDetails = await Future.wait(
        response.products.map((cartProduct) async {
          final product = await apiService.getProduct(cartProduct.productId);
          return CartProductWithDetails(
            quantity: cartProduct.quantity,
            product: product,
          );
        }),
      );
      return SuccessResponse(CartEntity(
        id: response.id,
        userId: response.userId,
        date: response.date,
        product: productsWithDetails,
      ));
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }


  // Add cart function
  Future<ApiResponse<Cart>> addCart(Cart cart) async {
    try {
      final response = await apiService.addCart(cart);
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  // Delete cart function
  Future<ApiResponse<void>> deleteCart(int id) async {
    try {
      await apiService.deleteCart(id);
      return SuccessResponse(null);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }

  // Update cart function
  Future<ApiResponse<Cart>> updateCart(int id, Cart cart) async {
    try {
      final response = await apiService.updateCart(id, cart);
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(e.toString());
    }
  }
}






// import 'package:weather_app/data/modal/cart/cart.dart';