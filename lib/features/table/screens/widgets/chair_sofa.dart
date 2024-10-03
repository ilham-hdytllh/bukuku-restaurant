import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

enum RotateDirection { none, left, right, upsideDown }

class ChairSofa extends StatelessWidget {
  final bool rotate;
  final RotateDirection rotateDirection;

  const ChairSofa({
    Key? key,
    this.rotate = false,
    this.rotateDirection = RotateDirection.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      height: 28,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7.2, left: 7.2),
            child: Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2.4),
                  topRight: Radius.circular(2.4),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 18,
                width: 6,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2.4),
                    bottomRight: Radius.circular(2.4),
                  ),
                ),
              ),
              const SizedBox(
                width: 1.2,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 18,
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(
                width: 1.2,
              ),
              Container(
                height: 18,
                width: 6,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2.4),
                    bottomLeft: Radius.circular(2.4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1.2,
          ),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2.4),
            ),
          ),
        ],
      ),
    );
    if (rotate) {
      double angle = 0.0;
      switch (rotateDirection) {
        case RotateDirection.left:
          angle = -math.pi / 2; // Putar 90 derajat berlawanan arah jarum jam
          break;
        case RotateDirection.right:
          angle = math.pi / 2; // Putar 90 derajat searah jarum jam
          break;
        case RotateDirection.upsideDown:
          angle = math.pi; // Putar 180 derajat
          break;
        case RotateDirection.none:
        default:
          break;
      }

      if (angle != 0.0) {
        child = Transform.rotate(
          angle: angle,
          child: child,
        );
      }
    }

    return child;
  }
}
