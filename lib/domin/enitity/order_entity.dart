import 'package:equatable/equatable.dart';
import 'package:weather_app/domin/enitity/product.dart';

class Order extends Equatable {
  final int id;
  final List<Product> products;
  final double totalPrice;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
  });
  
  @override
  
  List<Object?> get props =>[id,products,totalPrice, orderDate];
}
