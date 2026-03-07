import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../models/product_model.dart';
import '../../models/profile_model.dart';
import '../../network/remote/dio_helper.dart';
import 'home_states.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  ProfileModel? profile;



  void getProducts() async {
    emit(HomeLoading());

    try {
      final response = await DioHelper.getData(
        url: '/products',
      );

      products = List<ProductModel>.from(
        response.data.map((e) => ProductModel.fromJson(e)),
      );

      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void getProfile() async {
    try {
      final response = await DioHelper.getData(
        url: '/auth/profile',
        token: token,
      );

      profile = ProfileModel.fromJson(response.data);

      emit(ProfileLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}