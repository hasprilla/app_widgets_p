import 'package:app_widgets_p/ahorros/widgets/card_ahorro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/ahorros_cubit.dart';

class AhorrosScreen extends StatelessWidget {
  const AhorrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AhorrosCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Ahorros'),
        ),
        body: BlocBuilder<AhorrosCubit, AhorrosState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: state.pageController,
                    onPageChanged: (int page) {
                      context.read<AhorrosCubit>().onPageChanged(page);
                    },
                    itemCount: 9,
                    itemBuilder: (context, index) {
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
                        child: const CardAhorro(),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(9, (int index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<AhorrosCubit>().changePage(index);
                        },
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == state.currentPage
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
