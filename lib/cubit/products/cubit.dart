import 'package:authentication_flutter/cubit/products/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_details_model.dart';
import '../../network/remote/dio_helper.dart';


class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  ProductDetailsModel? product;

  void getProductDetails(int id) async {
    emit(ProductDetailsLoading());

    try {
      final response = await DioHelper.getData(
        url: '/products/$id',
      );

      product = ProductDetailsModel.fromJson(response.data);

      emit(ProductDetailsSuccess());
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}