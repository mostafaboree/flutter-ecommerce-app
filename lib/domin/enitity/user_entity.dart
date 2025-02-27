import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String username;
  final String password;
  final String? token;

  User({
    required this.username,
    required this.password,
    this.token,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [username, password, token];
}
