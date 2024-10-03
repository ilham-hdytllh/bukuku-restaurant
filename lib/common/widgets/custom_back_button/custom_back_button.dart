import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Iconsax.arrow_left_copy,
            size: TSizes.iconMd,
            color: TColors.primary,
          ),
          const SizedBox(
            width: TSizes.spaceBtwText,
          ),
          Text(
            "Back",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: TColors.primary),
          )
        ],
      ),
    );
  }
}
