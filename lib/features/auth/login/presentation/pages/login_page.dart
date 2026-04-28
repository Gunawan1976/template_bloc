import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/core/enum.dart';

import 'package:vcc_remake_bloc/features/auth/login/presentation/bloc/login_bloc.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    masukanCaptchaController.dispose();
    super.dispose();
  }

  // Helper untuk memicu event login
  void _onLoginPressed() {
    context.read<LoginBloc>().add(
      LoginButtonPressed(
        id: usernameController.text,
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
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoadingState.failure) {
            // Handle failure
          }
          else if (state.status == LoadingState.success) {
            // Navigasi ke IndexPage jika login BERHASIL menggunakan go_router
            context.go('/home');
          }
        },
        builder: (context, state) {
          if (state.status == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

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
                            obscureText: state.isPasswordObscured,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Masukan Password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(TogglePasswordVisibility());
                                },
                                child: Icon(
                                  state.isPasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
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
}
