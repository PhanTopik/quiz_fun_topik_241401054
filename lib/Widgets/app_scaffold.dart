import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    // Warna latar belakang otomatis mengikuti tema global
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}