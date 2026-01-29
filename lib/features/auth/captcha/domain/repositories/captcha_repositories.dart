
import '../../../../../core/data_state.dart';
import '../entities/captcha_entities.dart';

abstract class CaptchaRepository {
  Future<DataState<CaptchaEntities>> getCaptcha();
}