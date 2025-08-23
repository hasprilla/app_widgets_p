import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'ahorros_state.dart';

class AhorrosCubit extends Cubit<AhorrosState> {
  AhorrosCubit()
      : super(AhorrosState(
          currentPage: 0,
          pageController: PageController(viewportFraction: 0.8),
        ));

  void changePage(int newPage) {
    state.pageController.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentPage: newPage));
  }

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
