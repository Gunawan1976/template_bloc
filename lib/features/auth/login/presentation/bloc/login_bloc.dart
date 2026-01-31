// lib/auth/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vcc_remake_bloc/core/constant.dart';
import 'package:vcc_remake_bloc/core/utils/secure_storage_util.dart';
import 'package:vcc_remake_bloc/features/auth/login/domain/entities/profile_entities.dart';
import '../../../../../core/data_state.dart';
import '../../../../../core/enum.dart';
import '../../domain/entities/login_entities.dart';
import '../../domain/usecases/login_usecases.dart';
import '../../domain/usecases/profile_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final GetProfileUseCase getProfileUseCase;


  LoginBloc({required this.loginUseCase,required this.getProfileUseCase}) : super(const LoginState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<GetProfileRequested>(_onGetProfileRequested);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      isPasswordObscured: !state.isPasswordObscured,
    ));
  }
  
  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event,
      Emitter<LoginState> emit,
      )async{
    await UserStorageWrapper().deleteAllField();
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(status: LoadingState.loading));

    final result = await loginUseCase.loginRepository.login(id: event.id,
        password: event.password,
        captcha: "",
        captchaId: "",
        csrfToken: "");

    if (result is DataSuccess<LoginEntities>) {
      final user = result.data!;

      await UserStorageWrapper()
          .setField(Constant.APP_TOKEN, user.accessToken);

      await UserStorageWrapper()
          .setField(Constant.REFRESH_TOKEN, user.refreshToken);

      emit(state.copyWith(
        status: LoadingState.success,
        user: user,
      ));
    } else if (result is DataFailed<LoginEntities>) {
      emit(state.copyWith(
        status: LoadingState.failure,
        error: result.error,
      ));
    }
  }

  Future<void> _onGetProfileRequested(
      GetProfileRequested event,
      Emitter<LoginState> emit,
      ) async {
    if (state.profile != null) return;

    emit(state.copyWith(status: LoadingState.loading));

    await getProfileUseCase().then((value) {
      if (value is DataSuccess<ProfileEntities>) {
        emit(state.copyWith(
          status: LoadingState.success,
          profile: value.data,
        ));
      } else if (value is DataFailed<ProfileEntities>) {
        emit(state.copyWith(
          status: LoadingState.failure,
          error: value.error,
        ));
      }
    },);
  }

}
