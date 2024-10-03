import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/features/table/screens/widgets/chair_single_sheet_component.dart';

class Component6 extends StatelessWidget {
  final String tableName;
  final int tableQty;
  const Component6({
    super.key,
    required this.tableName,
    required this.tableQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 85,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 70,
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
