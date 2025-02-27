
import 'package:equatable/equatable.dart';

import '../../../data/modal/user/user.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String user; // Replace `User` with your user model
  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}