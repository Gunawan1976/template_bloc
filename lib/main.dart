import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/presentation/bloc/captcha_bloc.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';

import 'core/network/injection.dart';
import 'features/auth/login/presentation/pages/login_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(create: (context) => locator(),),
      BlocProvider<CaptchaBloc>(create: (context) => locator(),)
    ], child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child:  MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const LoginPage(),
        )
    ));
  }
}
