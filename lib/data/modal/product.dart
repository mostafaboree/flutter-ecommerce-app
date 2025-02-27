import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domin/enitity/product.dart';

import 'rating.dart';

part 'product.g.dart';
@JsonSerializable()
class ProductModel {
  
final int id;
final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;
  ProductModel({
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.id,
    required this.title,
  });


@override
String toString() {
  return 'ProductModel(id: $id, title: $title, price: $price, image: $image)';
}

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

 
 

  

Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating.toEntity(),
    );
  }

}