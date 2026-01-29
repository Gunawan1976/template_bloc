import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import BLoC dan Event Anda
import 'package:vcc_remake_bloc/features/auth/captcha/presentation/bloc/captcha_bloc.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:vcc_remake_bloc/features/auth/login/domain/entities/login_entities.dart'; // Impor entity
import 'package:vcc_remake_bloc/features/home_pages.dart';

// Import widget kustom Anda
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

class LoginPage extends StatefulWidget {
  final bool? isLoginSSO;
  const LoginPage({super.key, this.isLoginSSO});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController masukanCaptchaController = TextEditingController();

  // Simpan captchaId untuk dikirim saat login
  String _captchaId = '';

  @override
  void initState() {
    // Tidak perlu memanggil BlocProvider.of() di sini.
    context.read<CaptchaBloc>().add(FetchCaptcha());
    super.initState();
  }

  @override
  void dispose() {
    // 5. WAJIB dispose semua controller
    usernameController.dispose();
    passwordController.dispose();
    masukanCaptchaController.dispose();
    super.dispose();
  }

  // Helper untuk memicu event login
  void _onLoginPressed() {
    context.read<LoginBloc>().add(
      // Ganti dengan event login Anda yang sebenarnya
      LoginButtonPressed(
        email: usernameController.text,
        password: passwordController.text,
        captcha: masukanCaptchaController.text,
        captchaId: _captchaId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Login",
          fontSize: 20.sp,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      // 1. Gunakan BlocConsumer untuk LOGIN BLOC sebagai state utama halaman
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            // Tampilkan SnackBar jika login GAGAL
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: TextView(text:state.error,textColor: Colors.white,),
                backgroundColor: Colors.red,
              ),
            );
            // Muat ulang captcha setelah login gagal
            context.read<CaptchaBloc>().add(FetchCaptcha());
          }
          else if (state is LoginSuccess) {
            // Navigasi ke HomePage jika login BERHASIL
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePages(), // Kirim data user
              ),
            );
          }
        },
        builder: (context, state) {
          // Jika state login adalah loading, tampilkan loading di tengah
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Jika tidak, tampilkan form login
          return Center(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            key: const Key('textfield_username'),
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Masukan Username',
                            ),
                          ),
                          SizedBox(height: 25.h),
                          TextField(
                            key: const Key('textfield_password'),
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              // 6. Hint teks diperbaiki
                              hintText: 'Masukan Password',
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // 2. Gunakan BlocBuilder untuk CAPTCHA BLOC
                                  BlocBuilder<CaptchaBloc, CaptchaState>(
                                    builder: (context, state) {
                                      if (state is CaptchaLoading) {
                                        return const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (state is CaptchaSuccess) {
                                        // Simpan captchaId
                                        _captchaId = state.captcha.data?.captchaId ?? '';

                                        // 2. Gunakan data dari state!
                                        if (state.captcha.data?.captcha != null) {
                                          return Image.memory(
                                            key: const Key('image_captcha'),
                                            base64Decode(state.captcha.data!.captcha!),
                                            height: 100.h,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) {
                                              // Tampilkan error & retry jika decode gagal
                                              return _buildCaptchaError(context);
                                            },
                                          );
                                        }
                                        // Tampilkan error jika data gambar null
                                        return _buildCaptchaError(context);
                                      }
                                      if (state is CaptchaFailure) {
                                        // Tampilkan error & retry JIKA GAGAL fetch
                                        return _buildCaptchaError(context);
                                      }
                                      return const SizedBox(height: 50); // State initial
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    key: const Key('textfield_captcha'),
                                    controller: masukanCaptchaController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'Masukkan Captcha',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),

                          // 3. Tombol Login DITAMBAHKAN
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              key: const Key('button_login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              onPressed: _onLoginPressed,
                              child: TextView(
                                text: 'LOGIN',
                                fontSize: 16.sp,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget helper untuk menampilkan error captcha
  Widget _buildCaptchaError(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 40),
        const Text('Gagal memuat captcha'),
        TextButton(
          onPressed: () {
            // Panggil event untuk fetch ulang captcha
            context.read<CaptchaBloc>().add(FetchCaptcha());
          },
          child: const Text('Coba Lagi'),
        )
      ],
    );
  }
}