import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/endpoints.dart';
import 'register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      Response response = await DioHelper.postData(
        url: USERS,
        data: {
          "email": email,
          "name": email.split('@')[0], // simple name
          "password": password,
          "role": "customer",
          "avatar":
          "https://api.escuelajs.co/api/v1/files/0d65.png"
        },
      );

      // 🔥 PRINT FULL RESPONSE
      print("FULL RESPONSE: ${response.data}");


      emit(RegisterSuccess(response.data));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}