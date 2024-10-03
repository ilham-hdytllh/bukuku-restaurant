import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';

class Component5 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component5({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 125,
      child: Row(
        children: [
          const ChairSingleSheet(
            rotate: true,
            rotateDirection: RotatedDirection.right,
          ),
          const SizedBox(
            width: TSizes.spaceBtwText,
          ),
          Expanded(
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
          const SizedBox(
            width: TSizes.spaceBtwText,
          ),
          const ChairSingleSheet(
            rotate: true,
            rotateDirection: RotatedDirection.left,
          ),
        ],
      ),
    );
  }
}
