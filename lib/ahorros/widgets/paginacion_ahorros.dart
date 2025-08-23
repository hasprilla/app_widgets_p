import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(bottom: 35),
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
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentPage
                          ? Theme.of(context).primaryColor
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
