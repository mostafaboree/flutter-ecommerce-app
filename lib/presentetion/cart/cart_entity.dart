
import 'package:weather_app/data/modal/cart/cart_product.dart';
import 'package:weather_app/data/modal/product.dart';

class CartEntity {
  final int id;
  final int userId;
  final String date;
    final List<CartProductWithDetails> product;


  CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.product,
  });

}




  class CartProductWithDetails {

    final int quantity;
    final ProductModel product;

    CartProductWithDetails({
      required this.quantity,
      required this.product,
    });


  }