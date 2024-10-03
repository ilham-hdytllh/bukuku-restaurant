import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';

class Component4 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component4({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 125,
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.upsideDown,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 54,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.7),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: TColors.primary,
                  ),
                ),
                child: Text(
                  tableName.capitalizeAll(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.white),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: 0.7854,
              child: const ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.none,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: 0.7854,
              child: const ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
