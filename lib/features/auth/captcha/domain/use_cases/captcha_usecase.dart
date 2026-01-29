

import '../../../../../core/data_state.dart';
import '../entities/captcha_entities.dart';
import '../repositories/captcha_repositories.dart';

class CaptchaUsecase {
  final CaptchaRepository captchaRepository;

  CaptchaUsecase(this.captchaRepository);

  Future<DataState<CaptchaEntities>> getCaptcha() async {
    return await captchaRepository.getCaptcha();
  }
}