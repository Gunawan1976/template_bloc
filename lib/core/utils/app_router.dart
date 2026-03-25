import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/pages/login_page.dart';
import 'package:vcc_remake_bloc/features/detail_produk/presentation/pages/single_produk_page.dart';
import 'package:vcc_remake_bloc/features/index_page.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/index',
        name: 'index',
        builder: (context, state) => const IndexPage(),
      ),
      GoRoute(
        path: '/detail-produk/:id',
        name: 'detail-produk',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return SingleProdukPage(id: id);
        },
      ),
    ],
  );
}
