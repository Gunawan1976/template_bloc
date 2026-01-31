part of 'login_bloc.dart';

// Kelas dasar (abstract) untuk semua event
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Event saat tombol login ditekan
class LoginButtonPressed extends LoginEvent {
  final String id;
  final String password;
  final String captcha;
  final String captchaId;

  const LoginButtonPressed({
    required this.id,
    required this.password,
    required this.captcha,
    required this.captchaId,
  });

  @override
  List<Object> get props => [id, password, captcha, captchaId];
}

class TogglePasswordVisibility extends LoginEvent {}

class LogoutButtonPressed extends LoginEvent {}

class GetProfileRequested extends LoginEvent{}
