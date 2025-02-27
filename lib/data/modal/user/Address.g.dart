// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String? ?? 'No city',
      street: json['street'] as String? ?? 'No street',
      zipcode: json['zipcode'] as String? ?? 'No zipcode',
      number: (json['number'] as num?)?.toInt() ?? 0,
      geolocation:
          Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'zipcode': instance.zipcode,
      'number': instance.number,
      'geolocation': instance.geolocation,
    };
