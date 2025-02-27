// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] as String? ?? 'No email',
      username: json['username'] as String? ?? 'No username',
      password: json['password'] as String? ?? 'No password',
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String? ?? 'No phone',
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'id': instance.id,
    };
