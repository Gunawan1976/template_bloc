import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/domain/use_cases/captcha_usecase.dart';

import 'package:equatable/equatable.dart';

import '../../data/models/captcha_model.dart';
import '../../domain/entities/captcha_entities.dart';

part 'captcha_event.dart';
part 'captcha_state.dart';

class CaptchaBloc extends Bloc<CaptchaEvent,CaptchaState>{
  final CaptchaUsecase captchaUsecase;

  CaptchaBloc(this.captchaUsecase) : super(CaptchaInitial()){
    on<FetchCaptcha>(_FetchCaptcha);
  }

  Future<void> _FetchCaptcha(
      FetchCaptcha event,
      Emitter<CaptchaState> emit,
      )async{
    emit(CaptchaLoading());
    try {
      final captcha = await captchaUsecase.getCaptcha();
      if (captcha.dataState!.data != null) {
        emit(CaptchaSuccess(captcha.dataState ?? CaptchaEntities()));
      } else {
        emit(CaptchaFailure( error: captcha.dataState?.message ?? ""));
      }
    } catch (e) {
      emit(CaptchaFailure(error: e.toString()));
    }
  }
}