import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmerEffect extends StatelessWidget {
  final int itemCount;
  final double height;

  const shimmerEffect({Key? key, required this.itemCount, required this.height});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding:  EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
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
      },
    );
  }
}
