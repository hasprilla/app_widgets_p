import 'package:app_widgets_p/utils/prorroga.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/ahorros_cubit.dart';
import 'model/ahorros_model.dart';
import 'widgets/widgets.dart';

class AhorrosScreen extends StatelessWidget {
  const AhorrosScreen({super.key, required this.ahorros});

  final List<AhorroModel> ahorros;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AhorrosCubit(ahorrosIniciales: ahorros),
      child: _AhorrosScreenContent(ahorros: ahorros),
    );
  }
}

class _AhorrosScreenContent extends StatelessWidget {
  const _AhorrosScreenContent({
    required this.ahorros,
  });

  final List<AhorroModel> ahorros;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Ahorros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final cubit = context.read<AhorrosCubit>();
              cubit.actualizarAhorros(ahorros);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final cubit = context.read<AhorrosCubit>();
              final nuevoAhorro = AhorroModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                nombre: 'Nuevo Ahorro',
                monto: 1000.0,
                fechaCreacion: DateTime.now(),
              );
              cubit.agregarAhorro(nuevoAhorro);
            },
          ),
        ],
      ),
      body: BlocBuilder<AhorrosCubit, AhorrosState>(
        builder: (context, state) {
          if (state.ahorros.isEmpty) {
            return const Center(
              child: Text('No tienes ahorros registrados'),
            );
          }

          return Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: TextSpanProrrogaWidget(
                        fecha: '25-08-2025 13:57:59',
                        dias: '5',
                        valorExtendido: 'no',
                        textSpanValido: TextSpan(
                          text: 'prórrogar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Prórroga solicitada',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                        ),
                        textSpanInvalido: const TextSpan(
                            text: ''), // Texto vacío cuando no está disponible
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: state.pageController,
                  onPageChanged: (int page) {
                    context.read<AhorrosCubit>().onPageChanged(page);
                  },
                  itemCount: state.itemCount,
                  itemBuilder: (context, index) {
                    final ahorro = state.ahorros[index];

                    return AnimatedBuilder(
                      animation: state.pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (state.pageController.position.haveDimensions) {
                          value = state.pageController.page! - index;
                          value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                        }
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: CardAhorro(ahorro: ahorro),
                    );
                  },
                ),
              ),
              PaginacionAhorros(
                currentPage: state.currentPage,
                itemCount: state.itemCount,
                onPageChanged: (index) {
                  context.read<AhorrosCubit>().changePage(index);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
