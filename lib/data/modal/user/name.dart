
import 'package:json_annotation/json_annotation.dart';
 part 'name.g.dart';


@JsonSerializable()
class Name {
  @JsonKey(defaultValue: 'No firstname') // Handle null
  final String firstname;

  @JsonKey(defaultValue: 'No lastname') // Handle null
  final String lastname;

   const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}