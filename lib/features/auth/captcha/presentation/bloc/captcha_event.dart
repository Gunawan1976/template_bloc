part of 'captcha_bloc.dart';

abstract class CaptchaEvent extends Equatable{
  const CaptchaEvent();

  @override
  List<Object> get props => [];
}

class FetchCaptcha extends CaptchaEvent{}