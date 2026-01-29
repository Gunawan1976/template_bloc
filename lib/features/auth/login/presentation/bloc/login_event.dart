// lib/auth/bloc/auth_event.dart
part of 'login_bloc.dart'; // Akan terhubung dengan auth_bloc.dart

// Kelas dasar (abstract) untuk semua event
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Event yang akan dipicu saat tombol login ditekan
class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final String captcha;
  final String captchaId;

  const LoginButtonPressed({
    required this.email,
    required this.password,
    required this.captcha,
    required this.captchaId,
  });

  @override
  List<Object> get props => [email, password, captcha, captchaId];
}
