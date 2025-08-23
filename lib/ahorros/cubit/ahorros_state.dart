part of 'ahorros_cubit.dart';

class AhorrosState {
  final int currentPage;
  final PageController pageController;
  final List<AhorroModel> ahorros;

  AhorrosState({
    required this.currentPage,
    required this.pageController,
    required this.ahorros,
  });

  int get itemCount => ahorros.length;

  AhorroModel? get currentAhorro =>
      currentPage >= 0 && currentPage < ahorros.length
          ? ahorros[currentPage]
          : null;

  AhorrosState copyWith({
    int? currentPage,
    PageController? pageController,
    List<AhorroModel>? ahorros,
  }) {
    return AhorrosState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
      ahorros: ahorros ?? this.ahorros,
    );
  }
}
