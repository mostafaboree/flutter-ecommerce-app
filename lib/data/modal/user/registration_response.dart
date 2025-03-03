

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/modal/user/user.dart';

import 'address.dart';
import 'geolocation.dart';
import 'name.dart';

part 'registration_response.g.dart';
@JsonSerializable()

class RegistrationResponse extends User{
  @JsonKey(defaultValue: 0)
  final int id;

  RegistrationResponse(this.id, {required super.email,
    required super.username, required super.password,
    required super.name, required super.address,
    required super.phone});


  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => _$RegistrationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);


  factory RegistrationResponse.withDefaults() {
    return RegistrationResponse(0, email: 'No email',
      username: 'No username',
      password: 'No password',
      name: const Name(firstname: 'No firstname', lastname: 'No lastname'),
      address: const Address(
        city: 'No city',
        street: 'No street',
        zipcode: 'No zipcode',
        number: 0,
        geolocation: Geolocation(lat: '0', long: '0'),
      ),
      phone: 'No phone',
    );
  }


}