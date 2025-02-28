
import 'package:json_annotation/json_annotation.dart';
part 'cart_product.g.dart';
@JsonSerializable()
class CartProduct {
@JsonKey(defaultValue: 0)
  final int productId;
@JsonKey(defaultValue: 0)
  final int  quantity;

  CartProduct({

    required this.productId,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}