import 'package:equatable/equatable.dart';
import 'package:weather_app/domin/enitity/product.dart';

class CartItem  extends Equatable{
  
   final Product  product;

 final int quantity;

  const CartItem({required this.product , this.quantity = 1});
  
  @override
  List<Object?> get props => [product,quantity];
}