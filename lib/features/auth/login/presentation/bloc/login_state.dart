part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool isPasswordObscured;
  final LoginEntities? user;
  final ProfileEntities? profile;
  final String error;

  const LoginState({
    this.status = LoginStatus.initial,
    this.isPasswordObscured = true,
    this.user,
    this.error = '',
    this.profile,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? isPasswordObscured,
    LoginEntities? user,
    ProfileEntities? profile,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      user: user ?? this.user,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, isPasswordObscured, user, error, profile];
}
