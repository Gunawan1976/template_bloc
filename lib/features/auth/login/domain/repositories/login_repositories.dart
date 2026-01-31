
import 'package:vcc_remake_bloc/features/auth/login/domain/entities/refresh_token_entities.dart';

import '../../../../../core/data_state.dart';
import '../entities/login_entities.dart';
import '../entities/profile_entities.dart';

abstract class LoginRepository {
  Future<DataState<LoginEntities>> login({required String id,required String password,required String captcha,required String captchaId, required String csrfToken});
  Future<DataState<ProfileEntities>>getProfile();
  Future<DataState<RefreshTokenEntities>>getRefreshToken({required String refreshToken});
}
