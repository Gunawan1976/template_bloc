import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/core/utils/app_router.dart';
import 'package:vcc_remake_bloc/core/utils/util_helper.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:vcc_remake_bloc/features/detail_produk/presentation/bloc/single_produk_bloc.dart';
import 'package:vcc_remake_bloc/features/home_page/presentation/home/home_bloc.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

import 'core/network/injection.dart';
import 'core/network/token_cache.dart';
import 'core/utils/secure_storage_util.dart';
import 'features/index/index_cubit.dart';
import 'features/root/root_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String key = String.fromEnvironment('KEY', defaultValue: 'dev-key');
  const String iv = String.fromEnvironment('IV', defaultValue: 'dev-iv');

  await UserSecureStorage.setField("sec_key", key);
  await UserSecureStorage.setField("iv", iv);
  await TokenCache.init();

  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => locator()),
        BlocProvider<HomeBloc>(create: (context) => locator()),
        BlocProvider<SingleProdukBloc>(create: (context) => locator(),),
        BlocProvider(
          create: (_) {
            final bloc = RootBloc()..add(StartGlobalTimer());
            UtilsHelper.rootBloc = bloc;
            return bloc;
          },
        ),
        BlocProvider<IndexCubit>(create: (context) => IndexCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listenWhen: (prev, curr) =>
              prev.showFiveMinutesDialog != curr.showFiveMinutesDialog,
          listener: (context, state) {
            if (state.showFiveMinutesDialog) {
              final navContext = AppRouter.router.configuration.navigatorKey.currentContext;

              if (navContext == null) return;

              // prevent dialog stack
              if (AppRouter.router.canPop()) return;

              showDialog(
                context: navContext,
                builder: (dialogContext) => AlertDialog(
                  title: const Text("Reminder"),
                  content: const Text("Sudah 5 menit berlalu"),
                  actions: [
                    TextButton(
                      onPressed: () => dialogContext.pop(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
        ),

        /// GLOBAL SNACKBAR
        BlocListener<RootBloc, RootState>(
          listenWhen: (prev, curr) => prev.snackbarId != curr.snackbarId,
          listener: (context, state) {
            UtilsHelper.scaffoldMessengerKey.currentState!
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: TextView(text: state.snackbarMessage ?? "",textColor: Colors.white,),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ),
              );
          },
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          scaffoldMessengerKey: UtilsHelper.scaffoldMessengerKey,
          title: 'Tempalte Bloc',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
