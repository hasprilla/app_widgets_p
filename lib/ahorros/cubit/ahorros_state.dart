part of 'ahorros_cubit.dart';

class AhorrosState {
  final int currentPage;
  final PageController pageController;
  final int itemCount;

  AhorrosState({
    required this.currentPage,
    required this.pageController,
    required this.itemCount,
  });

  AhorrosState copyWith({
    int? currentPage,
    PageController? pageController,
    int? itemCount,
  }) {
    return AhorrosState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
