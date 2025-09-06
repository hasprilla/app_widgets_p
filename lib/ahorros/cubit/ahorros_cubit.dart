import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/ahorros_model.dart';

part 'ahorros_state.dart';

class AhorrosCubit extends Cubit<AhorrosState> {
  AhorrosCubit({List<AhorroModel>? ahorrosIniciales})
      : super(AhorrosState(
          currentPage: 0,
          pageController: PageController(viewportFraction: 0.8),
          ahorros: ahorrosIniciales ?? [],
        ));

  void changePage(int newPage) {
    if (newPage >= 0 && newPage < state.itemCount) {
      state.pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      emit(state.copyWith(currentPage: newPage));
    }
  }

  void onPageChanged(int page) {
    if (page >= 0 && page < state.itemCount) {
      emit(state.copyWith(currentPage: page));
    }
  }

  void actualizarAhorros(List<AhorroModel> nuevosAhorros) {
    emit(state.copyWith(ahorros: nuevosAhorros));

    if (state.currentPage >= nuevosAhorros.length && nuevosAhorros.isNotEmpty) {
      changePage(nuevosAhorros.length - 1);
    } else if (nuevosAhorros.isEmpty) {
      emit(state.copyWith(currentPage: 0));
    }
  }

  void agregarAhorro(AhorroModel nuevoAhorro) {
    final nuevosAhorros = List<AhorroModel>.from(state.ahorros)
      ..add(nuevoAhorro);
    emit(state.copyWith(ahorros: nuevosAhorros));
  }

  void eliminarAhorro(int id) {
    final nuevosAhorros =
        state.ahorros.where((ahorro) => ahorro.id != id).toList();
    emit(state.copyWith(ahorros: nuevosAhorros));

    if (state.currentPage >= nuevosAhorros.length && nuevosAhorros.isNotEmpty) {
      changePage(nuevosAhorros.length - 1);
    }
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
