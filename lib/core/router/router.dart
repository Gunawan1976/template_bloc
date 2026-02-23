import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';

import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/login/presentation/providers/login_state.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authSessionProvider);

  return GoRouter(
    initialLocation: '/splash',

    // refreshListenable:
    // GoRouterRefreshStream(ref.watch(authSessionProvider.notifier).stream),

    redirect: (context, state) {
      final isAuth = authState.value?.isAuthenticated ?? false;
      final isLogin = state.matchedLocation == '/login';

      if (!isAuth && !isLogin) return '/login';
      if (isAuth && isLogin) return '/home';

      return null;
    },

    routes: [
      GoRoute(path: '/login', builder: (c, s) => const LoginPage()),
      // GoRoute(path: '/home', builder: (c, s) => const HomePage()),
      GoRoute(path: '/splash', builder: (c, s) => const SplashScreen()),
    ],
  );
});