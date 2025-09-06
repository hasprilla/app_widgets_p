import 'package:flutter/material.dart';

import '../model/ahorros_model.dart';

final List<AhorroModel> misAhorros = [
  AhorroModel(
    id: 1,
    nombre: 'Ahorro General',
    monto: 1250.00,
    icono: 'account_balance_rounded',
    fechaCreacion: DateTime(2023, 1, 15),
  ),
  AhorroModel(
    id: 2,
    nombre: 'Ahorro Emergencia',
    monto: 3500.00,
    icono: 'emergency',
    fechaCreacion: DateTime(2023, 2, 10),
  ),
  AhorroModel(
    id: 3,
    nombre: 'Ahorro Vacaciones',
    monto: 2100.00,
    icono: 'vacation',
    fechaCreacion: DateTime(2023, 3, 5),
  ),
];

final iconMap = {
  'account_balance_rounded': Icons.account_balance_rounded,
  'savings': Icons.savings,
  'emergency': Icons.medical_services,
  'vacation': Icons.beach_access,
  'education': Icons.school,
  'retirement': Icons.elderly,
  'home': Icons.home,
  'health': Icons.health_and_safety,
  'investment': Icons.trending_up,
  'personal': Icons.person,
};
