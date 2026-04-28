import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/features/auth/login/presentation/pages/login_page.dart';
import 'package:vcc_remake_bloc/features/detail_produk/presentation/pages/single_produk_page.dart';
import 'package:vcc_remake_bloc/features/index_page.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';
import 'package:vcc_remake_bloc/features/home_page/presentation/pages/home_pages.dart';
import 'package:vcc_remake_bloc/features/auth/profile_page.dart';
import 'package:vcc_remake_bloc/features/search/presentation/pages/search_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return IndexPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomePages(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: 'search',
                builder: (context, state) => const SearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/detail-produk/:id',
        name: 'detail-produk',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return SingleProdukPage(id: id);
        },
      ),
    ],
  );
}
