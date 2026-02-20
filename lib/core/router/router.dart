import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/providers/login_notifier.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';

import '../../features/auth/login/presentation/pages/login_page.dart';
import '../data_state.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(loginNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    // refreshListenable: GoRouterRefreshStream(
    //   ref.watch(loginNotifierProvider),
    // ),
    redirect: (context, state) {
      final auth = authState.value;

      final isLogin = state.matchedLocation == '/login';

      if (auth is DataFailed && !isLogin) {
        return '/login';
      }

      if (auth is DataSuccess && isLogin) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const IndexPage(),
      // ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
});