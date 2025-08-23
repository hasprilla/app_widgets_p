class AhorroModel {
  final String id;
  final String nombre;
  final double monto;
  final String icono;
  final DateTime fechaCreacion;

  AhorroModel({
    required this.id,
    required this.nombre,
    required this.monto,
    this.icono = 'account_balance_rounded',
    required this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'monto': monto,
      'icono': icono,
      'fechaCreacion': fechaCreacion.millisecondsSinceEpoch,
    };
  }

  factory AhorroModel.fromMap(Map<String, dynamic> map) {
    return AhorroModel(
      id: map['id'],
      nombre: map['nombre'],
      monto: map['monto'].toDouble(),
      icono: map['icono'] ?? 'account_balance_rounded',
      fechaCreacion: DateTime.fromMillisecondsSinceEpoch(map['fechaCreacion']),
    );
  }

  String get montoFormateado => '\$${monto.toStringAsFixed(2)}';

  AhorroModel copyWith({
    String? id,
    String? nombre,
    double? monto,
    String? icono,
    DateTime? fechaCreacion,
  }) {
    return AhorroModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      monto: monto ?? this.monto,
      icono: icono ?? this.icono,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}
