import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class RemoveCustomerContentDialog extends StatelessWidget {
  const RemoveCustomerContentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const Icon(
          Iconsax.warning_2_copy,
          color: TColors.error,
          size: TSizes.iconXL,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          "alertRemoveCustomerTitle".tr,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          "alertRemoveCustomerSubTitle".tr,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: TColors.dark.withOpacity(0.5)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
      ],
    );
  }
}
