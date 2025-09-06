import 'package:flutter/material.dart';
import 'validar_fecha_prorroga.dart';

class TextSpanProrrogaWidget extends StatelessWidget {
  final String fecha;
  final String dias;
  final String valorExtendido;
  final TextSpan textSpanValido;
  final TextSpan textSpanInvalido;

  const TextSpanProrrogaWidget({
    super.key,
    required this.fecha,
    required this.dias,
    required this.valorExtendido,
    required this.textSpanValido,
    this.textSpanInvalido = const TextSpan(text: ''),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: FechaProrrogaUtil.crearValidationStream(
        fecha: fecha,
        dias: dias,
        valorExtendido: valorExtendido,
      ),
      initialData: FechaProrrogaUtil.validarFechaProrroga(
        date: fecha,
        dias: dias,
        valorExtendido: valorExtendido,
      ),
      builder: (context, snapshot) {
        final isValid = snapshot.data ?? false;
        final textSpan = isValid ? textSpanValido : textSpanInvalido;

        return RichText(
          text: textSpan,
        );
      },
    );
  }
}
