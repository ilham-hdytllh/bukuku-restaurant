import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class ChipPermission extends StatelessWidget {
  const ChipPermission(
      {super.key, required this.label, required this.visibility});
  final String label;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return visibility == true
        ? Chip(
            labelPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            elevation: 0,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: TColors.darkerGrey,
            label: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: TColors.white,
                  ),
            ),
          )
        : const SizedBox();
  }
}
