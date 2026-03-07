// login_cubit.dart
import 'package:authentication_flutter/cubit/login/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../../models/login_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/endpoints.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final response = await DioHelper.postData(
        url: LOGIN,
        data: {
          "email": email,
          "password": password,
        },
      );

      print(response.data);

      final model = LoginModel.fromJson(response.data);

      /// 🔥 SAVE TOKEN
      token = model.accessToken;

      await CacheHelper.setData("token", model.accessToken);

      emit(LoginSuccess(model));
    } catch (e) {
      if (e is DioException) {
        emit(LoginError(e.response?.data.toString() ?? "Server Error"));
      } else {
        emit(LoginError("Unexpected Error"));
      }
    }
  }
}