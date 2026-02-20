import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/core/enum.dart';

import 'package:vcc_remake_bloc/features/index_page.dart';

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
    // context.read<CaptchaBloc>().add(FetchCaptcha());
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
    // context.read<LoginBloc>().add(
    //   // Ganti dengan event login Anda yang sebenarnya
    //   LoginButtonPressed(
    //     id: usernameController.text,
    //     password: passwordController.text,
    //     captcha: masukanCaptchaController.text,
    //     captchaId: _captchaId,
    //   ),
    // );
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
      body: Center(
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          // 6. Hint teks diperbaiki
                          hintText: 'Masukan Password',
                          suffixIcon: InkWell(
                            onTap: () {
                              // context.read<LoginBloc>().add(TogglePasswordVisibility());
                            },
                            child: Icon(
                             Icons.visibility,
                              color: Colors.grey,
                            ),
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
      )
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
            // context.read<CaptchaBloc>().add(FetchCaptcha());
          },
          child: const Text('Coba Lagi'),
        )
      ],
    );
  }
}