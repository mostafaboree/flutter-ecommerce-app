
import 'package:weather_app/data/modal/product/product.dart';


sealed class ProductState {
  ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
   ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;
   ProductError(this.error);
}