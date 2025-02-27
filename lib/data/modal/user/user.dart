


import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/modal/user/name.dart';

import 'Address.dart';
import 'Geolocation.dart';
part 'user.g.dart';
@JsonSerializable()
class User {
  @JsonKey(defaultValue: 'No email') // Handle null
  final String email;

  @JsonKey(defaultValue: 'No username') // Handle null
  final String username;

  @JsonKey(defaultValue: 'No password') // Handle null
  final String password;

   // Handle null
  //@JsonKey(defaultValue: Name(firstname: 'No firstname', lastname: 'No lastname')) // Handle null
  final Name name;

// Handle null
 
  final Address address;

  @JsonKey(defaultValue: 'No phone') // Handle null
  final String phone;



  User({
    required this.email,
    required this.username,
    required this.password,
    Name? name, // Optional parameter
    Address? address, // Optional parameter
    required this.phone,
  })  : name = name ?? Name(firstname: 'No firstname', lastname: 'No lastname'),
        address = address ??
            Address(
              city: 'No city',
              street: 'No street',
              zipcode: 'No zipcode',
              number: 0,
              geolocation: Geolocation(lat: '0', long: '0'),
            );
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}