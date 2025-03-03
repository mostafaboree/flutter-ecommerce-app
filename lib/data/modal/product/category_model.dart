import 'package:weather_app/domin/enitity/category.dart';

class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
    );
  }

  Category toEntity() {
    return Category(
      name: name,
    );
  }
}