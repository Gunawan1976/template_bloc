part of 'captcha_bloc.dart';

abstract class CaptchaState extends Equatable{
  const CaptchaState();

  @override
  List<Object> get props => [];
}

class CaptchaInitial extends CaptchaState{}

class CaptchaLoading extends CaptchaState{}

class CaptchaSuccess extends CaptchaState{
  final CaptchaEntities captcha;
  const CaptchaSuccess(this.captcha);
  @override
  List<Object> get props => [captcha];
}

class CaptchaFailure extends CaptchaState{
  final String error;

  const CaptchaFailure({required this.error});

  @override
  List<Object> get props => [error];
}