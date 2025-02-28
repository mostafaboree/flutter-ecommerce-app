

import 'package:json_annotation/json_annotation.dart';

import 'geolocation.dart';


part 'address.g.dart';

@JsonSerializable()

class Address {
  @JsonKey(defaultValue: 'No city') // Handle null
  final String city;

  @JsonKey(defaultValue: 'No street') // Handle null
  final String street;

  @JsonKey(defaultValue: 'No zipcode') // Handle null
  final String zipcode;

  @JsonKey(defaultValue: 0) // Handle null
  final int number;


    //@JsonKey(defaultValue: Geolocation(lat: '0', long: '0')) // Handle null

  final Geolocation geolocation;

 const Address({
    required this.city,
    required this.street,
    required this.zipcode,
    required this.number,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);


}