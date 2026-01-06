import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectlist extends StatelessWidget {
  final int itemCount;
  final double height;

  const ShimmerEffectlist({
    super.key,
    required this.itemCount,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      }),
    );
  }
}
