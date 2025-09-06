import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),

            // Product name placeholder
            Container(
              width: 120,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 8),

            // Price placeholder
            Container(
              width: 80,
              height: 18,
              color: Colors.white,
            ),
            const SizedBox(height: 16),

            // Date placeholder
            Container(
              width: 140,
              height: 14,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}