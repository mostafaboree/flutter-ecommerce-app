


import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/modal/cart/cart_product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart{
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int userId;
  final String date;

  final List<CartProduct> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
  Cart copyWith({List<CartProduct>? products}) {
    return Cart(
      id: id,
      userId: userId,
      date: date,
      products: products ?? this.products,
    );
  }
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);




}