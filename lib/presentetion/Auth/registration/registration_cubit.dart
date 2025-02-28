import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/modal/user/user.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/Auth/registration/registration_state.dart';

import '../../../data/remote/api_service.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Repo repository;

  RegistrationCubit(this.repository) : super(RegistrationInitial());

  /// Registers a new user with the provided user data.
  Future<void> register(User userData) async {
    emit(RegistrationLoading());

    try {
      final response = await repository.register(
        email: userData.email,
        username: userData.username,
        password: userData.password,
        firstname: userData.name.firstname,
        lastname: userData.name.lastname,
        address: userData.address.city,
        phone: userData.phone,
      );

      if (response is SuccessResponse<User>) {
        emit(RegistrationSuccess(response.data));
      } else if (response is ErrorResponse) {
        emit(RegistrationFailure((response as ErrorResponse).message));
      }
    } catch (e) {
      emit(RegistrationFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}