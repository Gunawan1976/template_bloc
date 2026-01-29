

import '../../../../../core/data_state.dart';
import '../entities/login_entities.dart';
import '../entities/logout_entities.dart';
import '../repositories/login_repositories.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<DataState<LoginEntities>> login({required String email,required String password,required String captcha, required String captchaId, required String csrfToken}) async {
    return await loginRepository.login(email: email,password: password, captcha: captcha, captchaId: captchaId, csrfToken: csrfToken);
  }

  Future<DataState<LoginEntities>> loginSSO({required String code, required String csrfToken}) async {
    return await loginRepository.loginSSO(code: code, csrfToken: csrfToken);
  }

  Future<DataState<LogoutEntities>> logout() async {
    return await loginRepository.logout();
  }

  Future<DataState<LoginEntities>> checkLogin(
      {required String email, required String password, required String captcha, required String captchaId}) async {
    return await loginRepository.checkLogin(email: email,
        password: password,
        captcha: captcha,
        captchaId: captchaId);
  }

}
