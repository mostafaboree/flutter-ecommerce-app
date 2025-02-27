import 'package:weather_app/domin/enitity/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProduct();

  Future<Product> getProduct(int id);

  
}