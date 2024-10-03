import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_sofa.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class Component3 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component3({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      width: 125,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ChairSofa(
            rotate: true,
            rotateDirection: RotateDirection.upsideDown,
          ),
          const SizedBox(
            height: TSizes.spaceBtwText,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2.4),
              border: Border.all(
                width: 3,
                color: TColors.primary,
              ),
            ),
            child: Text(
              tableName.capitalizeAll(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: TColors.white),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwText,
          ),
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.none,
              ),
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.none,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
