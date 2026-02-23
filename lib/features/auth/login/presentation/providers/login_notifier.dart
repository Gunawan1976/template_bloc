import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_entities.dart';
import '../../../../../core/data_state.dart';
import 'login_provider.dart';
import 'login_state.dart';

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

    final result = await AsyncValue.guard(() async {
      return await ref.read(loginUseCaseProvider).loginRepository.login(
        id: id,
        password: password,
        captcha: captcha,
        captchaId: captchaId,
        csrfToken: csrfToken,
      );
    });

    state = result;

    if (result.value is DataSuccess<LoginEntities>) {
      final token = (result.value as DataSuccess<LoginEntities>).data?.accessToken;
      await ref.read(authSessionProvider.notifier).setLogin(token!);
    }
  }

  Future<void> logout() async {
    await ref.read(authSessionProvider.notifier).logout();

    state = AsyncData(const DataFailed("Logged out"));
  }


  void reset() {
    state = AsyncData(DataSuccess(LoginEntities()));
  }
}