import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/api_constent.dart';
import 'package:weather_app/data/modal/cart/cart.dart';
import 'package:weather_app/data/modal/product.dart';
import 'package:weather_app/data/modal/user/Login_response.dart';
import 'package:weather_app/data/modal/user/registration_response.dart';
import 'package:weather_app/data/modal/user/user.dart';
import 'package:weather_app/data/modal/user/user_login.dart';
import 'package:weather_app/data/remote/dio_factory.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstent.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/products")
  Future<List<ProductModel>> getProducts();

  @GET("/products/{id}")
  Future<ProductModel> getProduct(@Path("id") int id);



  // User login
  @POST("/auth/login")
  Future<LoginResponse> login(@Body() UserLogin  credentials);

  // User registration
  @POST("/users")
  Future<RegistrationResponse> register(@Body() User  userData);

  //cart
  //get cart all carts of user
  @GET("/carts")
  Future<List<Cart>> getCart();

  //get cart by id
  @GET("/carts/{id}")
  Future<Cart> getCartById(@Path("id") int id);

  //add cart
  @POST("/cart")
  Future<Cart> addCart(@Body() Cart cart);
  //delete cart
  @DELETE("/cart/{id}")
  Future<void> deleteCart(@Path("id") int id);
  //update cart
  @PUT("/cart/{id}")
  Future<Cart> updateCart(@Path("id") int id,@Body() Cart cart);



}