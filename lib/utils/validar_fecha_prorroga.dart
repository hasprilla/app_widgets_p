import 'dart:async';

class FechaProrrogaUtil {
  static Stream<bool> crearValidationStream({
    required String fecha,
    required String dias,
    required String valorExtendido,
  }) {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return validarFechaProrroga(
        fecha: fecha,
        dias: dias,
        valorExtendido: valorExtendido,
      );
    });
  }

  static bool validarFechaProrroga({
    required String fecha,
    required String dias,
    required String valorExtendido,
  }) {
    if (valorExtendido.toLowerCase() != 'no') {
      return false;
    }

    try {
      final parts = fecha.split(' ');
      final dateParts = parts[0].split('-');
      final timeParts = parts[1].split(':');

      final limitDate = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
        int.parse(timeParts[2]),
      );

      final days = int.parse(dias);
      final startDate = DateTime(
        limitDate.year,
        limitDate.month,
        limitDate.day - days,
        limitDate.hour,
        limitDate.minute,
        limitDate.second,
      );

      final now = DateTime.now();

      return (now.isAfter(startDate) || now.isAtSameMomentAs(startDate)) &&
          (now.isBefore(limitDate) || now.isAtSameMomentAs(limitDate));
    } catch (e) {
      return false;
    }
  }

  static DateTime parsearFechaCompleta(String fecha) {
    final parts = fecha.split(' ');
    final dateParts = parts[0].split('-');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      int.parse(timeParts[2]),
    );
  }

  static DateTime calcularFechaInicio(DateTime fechaLimite, int dias) {
    return DateTime(
      fechaLimite.year,
      fechaLimite.month,
      fechaLimite.day - dias,
      fechaLimite.hour,
      fechaLimite.minute,
      fechaLimite.second,
    );
  }
}
