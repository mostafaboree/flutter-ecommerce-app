
import 'package:json_annotation/json_annotation.dart';
part 'Geolocation.g.dart';

@JsonSerializable()
class Geolocation {
  @JsonKey(defaultValue: '0') // Handle null
  final String lat;

  @JsonKey(defaultValue: '0') // Handle null
  final String long;

  const Geolocation({
    required this.lat,
    required this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) => _$GeolocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}