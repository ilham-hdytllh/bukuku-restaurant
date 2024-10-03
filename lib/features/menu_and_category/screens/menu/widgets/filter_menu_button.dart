import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class FilterMenuButton extends StatelessWidget {
  const FilterMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: TSizes.spaceBtwInputFields),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        height: TSizes.inputFieldHeight,
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: TColors.primary,
          ),
        ),
        child: const Icon(
          Iconsax.setting_4_copy,
          size: 24,
          color: TColors.primary,
        ),
      ),
    );
  }
}
