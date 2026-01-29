
import '../../../../../core/data_state.dart';
import '../entities/login_entities.dart';
import '../entities/logout_entities.dart';

abstract class LoginRepository {
  Future<DataState<LoginEntities>> login({required String email,required String password,required String captcha,required String captchaId, required String csrfToken});

  Future<DataState<LoginEntities>> loginSSO({required String code, required String csrfToken});

  Future<DataState<LogoutEntities>> logout();

  Future<DataState<LoginEntities>> checkLogin({required String email,required String password,required String captcha,required String captchaId});

}
