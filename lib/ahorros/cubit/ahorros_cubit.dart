import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'ahorros_state.dart';

class AhorrosCubit extends Cubit<AhorrosState> {
  AhorrosCubit()
      : super(AhorrosState(
          currentPage: 0,
          pageController: PageController(viewportFraction: 0.8),
          itemCount: 1,
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

  void syncWithArrays(List<dynamic> array1, List<dynamic> array2) {
    final minLength =
        array1.length <= array2.length ? array1.length : array2.length;
    if (minLength != state.itemCount) {
      emit(state.copyWith(itemCount: minLength));

      if (state.currentPage >= minLength) {
        changePage(minLength - 1);
      }
    }
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
