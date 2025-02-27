import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/modal/user/user.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/Auth/registration/registration_state.dart';

import '../../../data/remote/api_service.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Repo repository;

  RegistrationCubit(this.repository) : super(RegistrationInitial());

  Future<void> register(User userData) async {
    emit(RegistrationLoading());
    try {

      final response = await repository.register(userData.email, userData.username, userData.password,
          userData.name.firstname, userData.name.lastname, userData.address.city, userData.phone);
      if( response is SuccessResponse<User>){
        emit(RegistrationSuccess(response.data));
      }else{
        emit(RegistrationFailure( (response as ErrorResponse).message));
      }
    } catch (e) {
      emit(RegistrationFailure('An unexpected error occurred'));
    }
  }
}