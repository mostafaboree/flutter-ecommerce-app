
import 'package:equatable/equatable.dart';

import '../../../data/modal/user/user.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final User user; // Replace `User` with your user model
  const RegistrationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class RegistrationFailure extends RegistrationState {
  final String message;
  const RegistrationFailure(this.message);

  @override
  List<Object> get props => [message];
}