import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/core/utils/util_helper.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

import 'core/network/injection.dart';
import 'core/network/token_cache.dart';
import 'core/utils/secure_storage_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String key = String.fromEnvironment('KEY', defaultValue: 'dev-key');
  const String iv = String.fromEnvironment('IV', defaultValue: 'dev-iv');

  await UserSecureStorage.setField("sec_key", key);
  await UserSecureStorage.setField("iv", iv);
  await TokenCache.init();

  await setupLocator();

  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: UtilsHelper.navigatorKey,
        scaffoldMessengerKey: UtilsHelper.scaffoldMessengerKey,
        title: 'Tempalte Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
