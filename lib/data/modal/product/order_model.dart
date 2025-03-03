

import 'package:weather_app/domin/enitity/order_entity.dart';

import 'product.dart';

class OrderModel {
  final int id;
  final List<ProductModel> products;
  final double totalPrice;
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
      totalPrice: json['totalPrice'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  double get totalAmount {
    return products.fold(
        0, (previousValue, element) => previousValue + element.price);
  }

  Order toEntity() {
    return Order(
      id: id,
      products: products.map((product) => product.toEntity()).toList(),
      totalPrice: totalPrice,
      orderDate: orderDate,
    );
  }


}