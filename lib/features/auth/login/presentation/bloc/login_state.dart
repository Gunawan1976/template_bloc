// lib/Login/bloc/Login_state.dart
part of 'login_bloc.dart'; // Akan terhubung dengan Login_bloc.dart

// Kelas dasar (abstract) untuk semua state
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

// 1. State Awal
class LoginInitial extends LoginState {}

// 2. State Loading (saat proses login)
class LoginLoading extends LoginState {}

// 3. State Sukses (membawa data user)
class LoginSuccess extends LoginState {
  final DataState<LoginEntities> dataState; // Contoh data user

  const LoginSuccess({required this.dataState});

  @override
  List<Object> get props => [dataState];
}

// 4. State Gagal (membawa pesan error)
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}