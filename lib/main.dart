import 'package:flutter/material.dart';
import 'package:quiz_fun_topik/Config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quiz Fun Topik',
      theme: ThemeData(
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: createRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}