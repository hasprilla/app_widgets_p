import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/ahorros_cubit.dart';

class AhorrosScreen extends StatelessWidget {
  const AhorrosScreen(
      {super.key, required this.tiposAhorro, required this.montos});

  final List<String> tiposAhorro;
  final List<String> montos;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AhorrosCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Ahorros'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                final cubit = context.read<AhorrosCubit>();

                cubit.syncWithArrays(tiposAhorro, montos);
              },
            ),
          ],
        ),
        body: BlocBuilder<AhorrosCubit, AhorrosState>(
          builder: (context, state) {
            final minCount = tiposAhorro.length <= montos.length
                ? tiposAhorro.length
                : montos.length;

            if (minCount != state.itemCount) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<AhorrosCubit>()
                    .syncWithArrays(tiposAhorro, montos);
              });
            }

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: state.pageController,
                    onPageChanged: (int page) {
                      context.read<AhorrosCubit>().onPageChanged(page);
                    },
                    itemCount: state.itemCount,
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
                        child: CardAhorro(
                          index: index,
                          tiposAhorro: tiposAhorro,
                          montos: montos,
                        ),
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
      ),
    );
  }
}

class CardAhorro extends StatelessWidget {
  final int index;
  final List<String> tiposAhorro;
  final List<String> montos;

  const CardAhorro({
    super.key,
    required this.index,
    required this.tiposAhorro,
    required this.montos,
  });

  @override
  Widget build(BuildContext context) {
    final safeIndex =
        index < tiposAhorro.length && index < montos.length ? index : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_balance_rounded,
                  size: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tiposAhorro[safeIndex],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      montos[safeIndex],
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaginacionAhorros extends StatelessWidget {
  final int currentPage;
  final int itemCount;
  final ValueChanged<int> onPageChanged;

  const PaginacionAhorros({
    super.key,
    required this.currentPage,
    required this.itemCount,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onPageChanged(index),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentPage
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
