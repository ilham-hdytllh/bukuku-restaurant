import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
      required this.child,
      required this.borderColor,
      required this.height});
  final Widget child;
  final Color borderColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: height,
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
