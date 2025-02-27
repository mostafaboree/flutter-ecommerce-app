// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      firstname: json['firstname'] as String? ?? 'No firstname',
      lastname: json['lastname'] as String? ?? 'No lastname',
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
