import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DynamicShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final int itemCount;
  final Axis scrollDirection;
  final bool isList;
  final bool isGrid;
  final double spacing;
  final int gridCrossAxisCount;

  const DynamicShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius,
    this.itemCount = 5,
    this.scrollDirection = Axis.horizontal,
    this.isList = false,
    this.isGrid = false,
    this.spacing = 8.0,
    this.gridCrossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: isGrid
          ? GridView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCrossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => _shimmerBox(),
            )
          : SizedBox(
              height: height + 10,
              child: ListView.builder(
                scrollDirection: scrollDirection,
                itemCount: itemCount,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: spacing),
                  child: _shimmerBox(),
                ),
              ),
            ),
    );
  }

  Widget _shimmerBox() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}
