import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/modal/product.dart';
import 'package:weather_app/domin/enitity/cart_Item.dart';



@JsonSerializable()

class CartItemModel  {
  

  final ProductModel product;
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });


  // Factory constructor for deserialization (JSON to CartItem)
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  // Method for serialization (CartItem to JSON)
  

  CartItem toEntity() {
    return CartItem(
      product: product.toEntity(),
      quantity: quantity,
    );
  }
}