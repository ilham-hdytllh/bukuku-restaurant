import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ListTileProfile extends StatelessWidget {
  const ListTileProfile(
      {super.key,
      required this.title,
      required this.content,
      required this.edited});
  final String title, content;
  final bool edited;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(
          left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: TColors.grey),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: TColors.darkGrey),
              ),
              const SizedBox(
                width: 8,
              ),
              edited == true
                  ? const Icon(
                      Iconsax.arrow_right_3_copy,
                      size: TSizes.iconMd - 5,
                      color: TColors.darkGrey,
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
