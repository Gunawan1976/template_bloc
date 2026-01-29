import 'package:dio/dio.dart';

import '../../../../../core/data_state.dart';
import '../../domain/entities/captcha_entities.dart';
import '../../domain/repositories/captcha_repositories.dart';
import '../models/captcha_model.dart';
import '../sources/captcha_api_service.dart';

class CaptchaRepositoryImpl extends CaptchaRepository{
  final CaptchaApiService apiService;

  CaptchaRepositoryImpl({required this.apiService});

  @override
  Future<DataState<CaptchaEntities>> getCaptcha() async{
    try{
      CaptchaModel response = await apiService.getCaptcha();
      return DataSuccess(response);
    }on DioException catch (e){
      return DataError(DioException(
          error: e.message ?? "",
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          response: e.response));
    }
  }

}