import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 100,
                height: 150,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 15,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 15,
                      width: 100,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 15,
                      width: 80,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
