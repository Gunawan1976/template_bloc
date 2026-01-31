import 'package:vcc_remake_bloc/features/auth/login/domain/entities/refresh_token_entities.dart';

import '../../../../../core/data_state.dart';
import '../repositories/login_repositories.dart';

class GetRefreshTokenUseCase {
  final LoginRepository repository;

  GetRefreshTokenUseCase(this.repository);

  Future<DataState<RefreshTokenEntities>> call({required String refreshToken}) {
    return repository.getRefreshToken(refreshToken: refreshToken);
  }
}