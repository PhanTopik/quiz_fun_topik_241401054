import 'package:quiz_fun_topik/Config/routes.dart';
import 'package:quiz_fun_topik/Config/app_theme.dart';
import 'package:quiz_fun_topik/Services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeNotifier,
      builder: (context, currentThemeMode, child) {
        return MaterialApp.router(
          title: 'Quiz Fun Topik',
          routerConfig: _router,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentThemeMode,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}