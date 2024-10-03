import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PromoMenuInDialog extends StatelessWidget {
  const PromoMenuInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 60,
        ),
        const Icon(
          Iconsax.percentage_square_copy,
          color: TColors.darkGrey,
          size: 80,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          "Belum ada promo untuk menu ini",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: TColors.darkGrey,
              ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
