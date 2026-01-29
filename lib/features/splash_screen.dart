import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/login/presentation/pages/login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Future.delayed(
      //     const Duration(seconds: 3),
      // () => context.goNamed(RouterEnum.bloc));
      // context.read<LoginBloc>().add(CheckIsLoginEvent());
      Future.delayed(const Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ));
    });
    super.initState();
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