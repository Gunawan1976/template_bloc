import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/storage/secure_storage_provider.dart';

class LoginState {
  final bool isAuthenticated;

  const LoginState({required this.isAuthenticated});
}

class LoginSessionNotifier extends AsyncNotifier<LoginState> {
  static const tokenKey = "access_token";

  @override
  Future<LoginState> build() async {
    final storage = ref.read(userStorageProvider);
    final token = await storage.getField(tokenKey);
    return LoginState(isAuthenticated: token != null);
  }

  Future<void> setLogin(String token) async {
    final storage = ref.read(userStorageProvider);
    await storage.setField(tokenKey, token);
    state = const AsyncData(LoginState(isAuthenticated: true));
  }

  Future<void> logout() async {
    final storage = ref.read(userStorageProvider);
    await storage.deleteAllField();
    state = const AsyncData(LoginState(isAuthenticated: false));
  }
}

final authSessionProvider =
AsyncNotifierProvider<LoginSessionNotifier, LoginState>(
  LoginSessionNotifier.new,
);