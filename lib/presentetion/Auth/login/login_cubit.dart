import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/sheradprefernc.dart';
import 'package:weather_app/data/modal/user/user.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';

import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final Repo authRepository;

  LoginCubit(this.authRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await authRepository.login(email, password);
      if (user is SuccessResponse<String>) {
        emit(LoginSuccess(user.data));
        await SharedPreferencesHelper.setAuthenticated(user.data);
      } else {
        emit(LoginFailure((user as ErrorResponse).message));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}