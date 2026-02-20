import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_entities.dart';
import '../../../../../core/data_state.dart';
import 'login_provider.dart';

final loginNotifierProvider =
AsyncNotifierProvider<LoginNotifier, DataState<LoginEntities>>(
  LoginNotifier.new,
);

class LoginNotifier extends AsyncNotifier<DataState<LoginEntities>> {
  @override
  FutureOr<DataState<LoginEntities>> build() {
    return DataSuccess(
      LoginEntities()
    ); // initial state
  }

  Future<void> login({
    required String id,
    required String password,
    required String captcha,
    required String captchaId,
    required String csrfToken,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await ref.read(loginUseCaseProvider).loginRepository.login(
        id: id,
        password: password,
        captcha: captcha,
        captchaId: captchaId,
        csrfToken: csrfToken,
      );
    });
  }

  Future<void> logout() async {
    state = AsyncData(const DataFailed("Logged out"));
  }


  void reset() {
    state = AsyncData(DataSuccess(LoginEntities()));
  }
}