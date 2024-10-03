import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';

class Component2 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component2({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 125,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.right,
              ),
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.right,
              ),
            ],
          ),
          const SizedBox(
            width: TSizes.spaceBtwText,
          ),
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: 50,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2.4),
              border: Border.all(
                width: 3,
                color: TColors.primary,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tableName.capitalizeAll(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: TSizes.spaceBtwText,
          ),
          const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.left,
              ),
              ChairSingleSheet(
                rotate: true,
                rotateDirection: RotatedDirection.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
