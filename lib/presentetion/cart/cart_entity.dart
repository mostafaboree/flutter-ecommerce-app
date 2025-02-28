
import 'package:weather_app/data/modal/cart/cart_product.dart';
import 'package:weather_app/data/modal/product/product.dart';

import '../../data/modal/cart/cart.dart';

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


  Cart toCart() {
    return Cart(
      id: id,
      userId: userId,
      date: date,
      products: product.map((item) => CartProduct(
        productId: item.product.id, // Extract productId from ProductModel
        quantity: item.quantity,
      )).toList(),
    );
  }


}




  class CartProductWithDetails {

    final int quantity;
    final ProductModel product;

    CartProductWithDetails({
      required this.quantity,
      required this.product,
    });




  }