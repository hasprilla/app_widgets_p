import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      );
}
