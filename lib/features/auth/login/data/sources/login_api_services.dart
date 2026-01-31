import 'package:dio/dio.dart';
import 'package:vcc_remake_bloc/features/auth/login/data/models/profile_model.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/network/injection.dart';
import '../models/login_models.dart';
import '../models/refresh_token_model.dart';
// import '../models/logout_models.dart';

abstract class LoginApiServices {
  Future<LoginModel> login({
    required String id,
    required String password,
    required String captcha,
    required String captchaId,
    required String csrfToken
  });

  Future<ProfileModel> getProfile();

  Future<RefreshTokenModel>getRefreshToken({required String refreshToken});
}

class LoginApiServiceImpl extends LoginApiServices{
  Dio dio;

  LoginApiServiceImpl([Dio? dio]) : dio = dio ?? locator<Dio>();

  @override
  Future<LoginModel> login({required String id, required String password, required String captcha, required String captchaId, required String csrfToken}) async{
    try {
      return await dio.post('auth/login',
        data: {
          "username": id,
          "password":password,
          "expiresInMins": 30
        },
        options: Options(
          // same as credentials: 'include'
          extra: {"withCredentials": true},
        ),
      ).then((value) async{
        return LoginModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return LoginModel(
      );
    }
  }

  @override
  Future<ProfileModel> getProfile() async{
    try {
      return await dio.get('auth/me',
        // options: Options(
        //   // same as credentials: 'include'
        //   extra: {"withCredentials": true},
        // ),
      ).then((value) async{
        return ProfileModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return ProfileModel();
    }
  }

  @override
  Future<RefreshTokenModel> getRefreshToken({required String refreshToken}) async{
    try {
      return await dio.post('auth/refresh',
        data: {
          "refreshToken": refreshToken,
          "expiresInMins": 30
        }
        // options: Options(
        //   // same as credentials: 'include'
        //   extra: {"withCredentials": true},
        // ),
      ).then((value) async{
        return RefreshTokenModel.fromJson(value.data);
      });
    } on DioException catch (e) {
      return RefreshTokenModel();
    }
  }
}
