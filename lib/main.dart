import 'package:app_widgets_p/ahorros/ahorros_screen.dart';
import 'package:app_widgets_p/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Widgets',
      theme: AppTheme().getTheme(),
      home: const AhorrosScreen(),
    );
  }
}
