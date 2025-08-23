import 'package:app_widgets_p/ahorros/ahorros_screen.dart';
import 'package:app_widgets_p/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Map<String, String> misAhorros = {
  'Ahorro General': '\$1,250.00',
  'Ahorro Emergencia': '\$3,500.00',
  'Ahorro Vacaciones': '\$2,100.00',
  'Ahorro Educación': '\$4,300.00',
  'Ahorro Retiro': '\$8,750.00',
  'Ahorro Hogar': '\$1,900.00',
  'Ahorro Salud': '\$2,500.00',
  'Ahorro Inversión': '\$5,200.00',
  'Ahorro Personal': '\$1,000.00',
  'Ahorro Otros': '\$44,000.00',
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Widgets',
      theme: AppTheme().getTheme(),
      home: AhorrosScreen(
        ahorrosData: misAhorros,
      ),
    );
  }
}
