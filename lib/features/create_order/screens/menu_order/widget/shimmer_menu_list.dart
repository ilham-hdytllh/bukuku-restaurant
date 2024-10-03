import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMenuList extends StatelessWidget {
  const ShimmerMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 14,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 65,
        child: Shimmer.fromColors(
          baseColor: TColors.darkGrey,
          highlightColor: TColors.grey,
          child: const SizedBox(),
        ),
      ),
    );
  }
}
