import 'package:flutter/material.dart';

import '../data/ahorros.dart';
import '../model/ahorros_model.dart';

class CardAhorro extends StatelessWidget {
  final AhorroModel ahorro;

  const CardAhorro({
    super.key,
    required this.ahorro,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = iconMap[ahorro.icono] ?? Icons.account_balance_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  size: 90,
                  color: Theme.of(context).primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity, // Ocupa todo el ancho disponible
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Ahorro seleccionado: ${ahorro.nombre}'),
                            ),
                          );
                        },
                        child: Text('Seleccionar'),
                      ),
                    ),
                    Text(
                      ahorro.nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ahorro.montoFormateado,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Creado: ${_formatDate(ahorro.fechaCreacion)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
