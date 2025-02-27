
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domin/enitity/rating.dart';

part 'rating.g.dart';

@JsonSerializable()
class RatingModel  {

  

  final int count;
  final double rate;

  RatingModel({
    required this.count,
    required this.rate,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json) ;
   

  Rating toEntity() {
    return Rating(
      count: count,
      rate: rate,
    );
  }
}