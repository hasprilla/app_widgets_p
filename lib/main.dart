import 'package:app_widgets_p/ahorros/ahorros_screen.dart';
import 'package:app_widgets_p/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final List<String> _tiposAhorro = [
  'Ahorro General',
  'Ahorro Emergencia',
  'Ahorro Vacaciones',
  'Ahorro Educación',
  'Ahorro Retiro',
  'Ahorro Hogar',
  'Ahorro Salud',
  'Ahorro Inversión',
  'Ahorro Personal',
  'Ahorro Otros',
  'Ahorro Ksj',
  'Ahorro Ksjssss',
  'Ahorro Otro mas',
];

final List<String> _montos = [
  '\$1,250.00',
  '\$3,500.00',
  '\$2,100.00',
  '\$4,300.00',
  '\$8,750.00',
  '\$1,900.00',
  '\$2,500.00',
  '\$5,200.00',
  '\$1,000.00',
  '\$44,000.00',
  '\$44,000.00',
  '\$3,00.00',
  '\$344,00.00',
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Widgets',
      theme: AppTheme().getTheme(),
      home: AhorrosScreen(
        tiposAhorro: _tiposAhorro,
        montos: _montos,
      ),
    );
  }
}
