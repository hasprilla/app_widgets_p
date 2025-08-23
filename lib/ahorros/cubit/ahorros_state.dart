part of 'ahorros_cubit.dart';

class AhorrosState {
  final int currentPage;
  final PageController pageController;
  
  AhorrosState({required this.currentPage, required this.pageController});
  
  AhorrosState copyWith({int? currentPage, PageController? pageController}) {
    return AhorrosState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
    );
  }
}
