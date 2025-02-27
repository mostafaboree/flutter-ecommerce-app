
import 'package:json_annotation/json_annotation.dart';


 part 'Login_response.g.dart';
@JsonSerializable()
class LoginResponse{
 final String token ;

 LoginResponse({required this.token});

  factory LoginResponse. fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);



}