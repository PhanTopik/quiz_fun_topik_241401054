import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Screens/signIn_screen.dart';
import '../Screens/signUp_screen.dart';
// import '../screens/detail_screen.dart';
// import '../screens/favorite_screen.dart';
// import '../screens/home_screen.dart';
// import '../screens/profile_screen.dart';
// import '../widgets/bottom_navigation_shell.dart';

class AppRoutes {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  // static const String home = '/home';
  // static const String favorites = '/favorites';
  // static const String profile = '/profile';
  // static const String details = '/details';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.signIn,
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
    //   StatefulShellRoute.indexedStack(
    //     builder: (context, state, navigationShell) {
    //       return BottomNavigationShell(navigationShell: navigationShell);
    //     },
    //     branches: [
    //       StatefulShellBranch(
    //         routes: [
    //           GoRoute(
    //             path: AppRoutes.home,
    //             builder: (context, state) => const HomeScreen(),
    //           ),
    //         ],
    //       ),
    //       StatefulShellBranch(
    //         routes: [
    //           GoRoute(
    //             path: AppRoutes.favorites,
    //             builder: (context, state) => const FavoriteScreen(),
    //           ),
    //         ],
    //       ),
    //       StatefulShellBranch(
    //         routes: [
    //           GoRoute(
    //             path: AppRoutes.profile,
    //             builder: (context, state) => const ProfileScreen(),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    //   GoRoute(
    //     path: '${AppRoutes.details}/:id',
    //     builder: (context, state) {
    //       final id = state.pathParameters['id'] ?? '1';
    //       return DetailScreen(animeId: id);
    //     },
    //   ),
    ],
  );
}
