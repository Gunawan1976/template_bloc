import 'package:dio/dio.dart';

import '../../../../../core/data_state.dart';
import '../../domain/entities/login_entities.dart';
import '../../domain/entities/logout_entities.dart';
import '../models/login_models.dart';
import '../models/logout_models.dart';
import '../sources/login_api_services.dart';
import '../../domain/repositories/login_repositories.dart';

class LoginRepositoryImp extends LoginRepository {
  LoginApiServices loginApiService;

  LoginRepositoryImp({required this.loginApiService});

  @override
  Future<DataState<LoginEntities>> login(
      {required String email,
      required String password,
      required String captcha,
      required String captchaId,
        required String csrfToken
      }) async {
    try {
      LoginModel response = await loginApiService.login(
          email: email,
          password: password,
          captcha: captcha,
          captchaId: captchaId, csrfToken: csrfToken);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataError(DioException(
          error: e.message ?? "",
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          response: e.response));
    }
  }

  @override
  Future<DataState<LogoutEntities>> logout() async {
    try {
      LogoutModel response = await loginApiService.logout();
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataError(DioException(
          error: e.message ?? "",
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          response: e.response));
    }
  }

  @override
  Future<DataState<LoginEntities>> loginSSO({required String code, required String csrfToken}) async {
    try {
      LoginModel response = await loginApiService.loginSSO(code: code, csrfToken: csrfToken);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataError(DioException(
          error: e.message ?? "",
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          response: e.response));
    }
  }

  @override
  Future<DataState<LoginEntities>> checkLogin({required String email, required String password, required String captcha, required String captchaId}) async{
    try {
      LoginModel response = await loginApiService.checkLogin(
          email: email,
          password: password,
          captcha: captcha,
          captchaId: captchaId);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataError(DioException(
          error: e.message ?? "",
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          response: e.response));
    }
  }
}
