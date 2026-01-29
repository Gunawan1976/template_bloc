import 'package:dio/dio.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/network/injection.dart';
import '../models/login_models.dart';
import '../models/logout_models.dart';

abstract class LoginApiServices {
  Future<LoginModel> login({
    required String email,
    required String password,
    required String captcha,
    required String captchaId,
    required String csrfToken
  });

  Future<LoginModel>loginSSO({
    required String code,
    required String csrfToken
  });

  Future<LoginModel> checkLogin({
    required String email,
    required String password,
    required String captcha,
    required String captchaId,
  });

  Future<LogoutModel> logout();
}

class LoginApiServiceImpl extends LoginApiServices{
  Dio dio;
  // Dio dio = locator<Dio>();

  LoginApiServiceImpl([Dio? dio]) : dio = dio ?? locator<Dio>();

  @override
  Future<LogoutModel> logout()async {
    try {
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      return await dio.post('auth/logout').then((value) {
        return LogoutModel.fromJson(value.data);
      },);
    } on DioException catch (e) {
      return LogoutModel(
        message: e.response?.data['message'],
        status: e.response?.statusCode ?? 500,
        data: null,
      );
    }
  }
  @override
  Future<LoginModel> loginSSO({required String code, required String csrfToken})async {
    try {
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      // FormData formData = FormData.fromMap({
      //   "code": code,
      // });
      Map<String, dynamic> jsonData = {
        "code": code,
      };
      return await dio.post('auth/sso-callback',data: jsonData).then((value) {
        return LoginModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return LoginModel(
        message: e.response?.data['message'],
        status: e.response?.statusCode ?? 500,
        data: null,
      );
    }
  }
  @override
  Future<LoginModel> login({required String email, required String password, required String captcha, required String captchaId, required String csrfToken}) async{
    try {
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      // dio.options.headers['X-CSRF-Token'] = '$csrftoken';
      return await dio.post('auth/login',
        data: {
          "email": email,
          "password":password,
          "captcha": captcha,
          "captcha_id": captchaId
        },
      ).then((value) async{
        // await UserSecureStorage.deleteField(Constant.CSRF_TOKEN_LOGIN);
        String? setCookieHeader = value.headers.map['set-cookie']?.last;
        // List<String> cookies = UtilsHelper.parseCookies(setCookieHeader);
        // String csrfTokenLogin = cookies[0].split(';')[0];
        // // print("csrftokenlogin : $csrfTokenLogin");
        // await UserSecureStorage.setField(Constant.CSRF_TOKEN_LOGIN, csrfTokenLogin);
        //
        // // Update ke cache agar interceptor bisa langsung pakai
        // TokenCache.updateTokens(tokenLogin: csrfTokenLogin);
        return LoginModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return LoginModel(
        message: e.response?.data['message'],
        errors: e.response?.data['errors'] == null ||  e.response?.data['errors'] == ""? null :Errors.fromJson(e.response?.data['errors']),
        vccCode: e.response?.data['vcc_code']!= null ? e.response?.data['vcc_code'] : null,
        status: e.response?.statusCode ?? 500,
        data: null,
      );
    }
  }

  @override
  Future<LoginModel> checkLogin({required String email, required String password, required String captcha, required String captchaId})async {
    try {
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      // dio.options.headers['X-CSRF-Token'] = '$csrftoken';
      return await dio.post('auth/check-bloc',
        data: {
          "email": email,
          "password":password,
          "captcha": captcha,
          "captcha_id": captchaId
        },
      ).then((value) async{
        return LoginModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return LoginModel(
        message: e.response?.data['message'],
        errors: e.response?.data['errors'] == null ||  e.response?.data['errors'] == ""? null :Errors.fromJson(e.response?.data['errors']),
        vccCode: e.response?.data['vcc_code']!= null ? e.response?.data['vcc_code'] : null,
        status: e.response?.statusCode ?? 500,
        data: null,
      );
    }
  }
}
