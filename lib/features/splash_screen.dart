import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/core/constant.dart';
import 'package:vcc_remake_bloc/core/utils/secure_storage_util.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  Future<void> _checkAuth() async {
    final token = await UserStorageWrapper()
        .getField(Constant.APP_TOKEN);

    // optional delay biar splash kelihatan dikit
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      context.go('/login');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}