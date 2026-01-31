import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcc_remake_bloc/core/constant.dart';
import 'package:vcc_remake_bloc/core/utils/secure_storage_util.dart';
import 'package:vcc_remake_bloc/features/index_page.dart';

import 'auth/login/presentation/pages/login_page.dart';
import 'auth/home_pages.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    print("isi dari ini ${Constant.APP_TOKEN}");
    _checkAuth();
    super.initState();
  }

  Future<void> _checkAuth() async {
    final token = await UserStorageWrapper()
        .getField(Constant.APP_TOKEN);

    print("isi dari ini $token");
    print("isi dari ini $token");

    // optional delay biar splash kelihatan dikit
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IndexPage()),
      );
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
            // Icon(
            //   Icons.airplanemode_active,
            //   color: Colors.white,
            //   size: SizeConfig.screenWidth * 0.1,
            // ),
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}