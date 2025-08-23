import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'ahorros_state.dart';

class AhorrosCubit extends Cubit<AhorrosState> {
  AhorrosCubit() : super(AhorrosState(
    currentPage: 0,
    pageController: PageController(viewportFraction: 0.8),
    itemCount: 0, // Inicializar en 0, se sincronizará con los datos
  ));

  void changePage(int newPage) {
    // Validar que la página esté dentro del rango
    if (newPage >= 0 && newPage < state.itemCount) {
      // Animar a la nueva página
      state.pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      
      // Actualizar el estado
      emit(state.copyWith(currentPage: newPage));
    }
  }

  void onPageChanged(int page) {
    // Actualizar el estado cuando la página cambia por deslizamiento
    if (page >= 0 && page < state.itemCount) {
      emit(state.copyWith(currentPage: page));
    }
  }

  // Método para sincronizar con los datos del Map
  void syncWithData(Map<String, String> ahorrosData) {
    final dataLength = ahorrosData.length;
    if (dataLength != state.itemCount) {
      emit(state.copyWith(itemCount: dataLength));
      
      // Si la página actual está fuera del nuevo rango, ajustarla
      if (state.currentPage >= dataLength && dataLength > 0) {
        changePage(dataLength - 1);
      } else if (dataLength == 0) {
        emit(state.copyWith(currentPage: 0));
      }
    }
  }

  @override
  Future<void> close() {
    // Dispose del controller cuando el cubit se cierra
    state.pageController.dispose();
    return super.close();
  }
}
