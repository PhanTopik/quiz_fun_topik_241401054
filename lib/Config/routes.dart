import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_fun_topik/Widgets/mainNavBar.dart';

import '../Screens/signIn_screen.dart';
import '../Screens/signUp_screen.dart';
import '../Screens/forgot_password_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/history_screen.dart';
import '../Screens/profile_screen.dart';
import '../Screens/quiz_screen.dart';

class AppRoutes {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/ForgotPassword';
  static const String home = '/Home';
  static const String history = '/History';
  static const String profile = '/Profile';
  static String quizDetail(String id) => '/quiz/$id';
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
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/quiz/:id',
        builder: (context, state) {
          final quizId = state.pathParameters['id'] ?? '';
          return QuizScreen(quizTitle: 'Kuis (ID: $quizId)');
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
