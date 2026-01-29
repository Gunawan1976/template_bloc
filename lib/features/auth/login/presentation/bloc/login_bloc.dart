// lib/auth/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data_state.dart';
import '../../../../../core/utils/aes_gcm.dart';
import '../../domain/entities/login_entities.dart';
import '../../domain/usecases/login_usecases.dart';

part 'login_event.dart';

part 'login_state.dart';

// Gabungkan file state dan event

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event,
      Emitter<LoginState> emit,) async {
    emit(LoginLoading());
    try {
      // Memanggil Use Case
      final user = await loginUseCase.login(
          email: event.email,
          password: event.password,
          captcha: event.captcha,
          captchaId: event.captchaId,
          csrfToken: "");

      // Sukses
      emit(LoginSuccess(dataState: user));
    } catch (e) {
      // Gagal
      emit(LoginFailure(error: e.toString()));
    }
  }
}