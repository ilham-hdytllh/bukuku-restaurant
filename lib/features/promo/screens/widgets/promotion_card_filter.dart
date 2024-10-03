import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class PromotionCardFilter extends StatelessWidget {
  const PromotionCardFilter(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.selected});
  final String title, subTitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: selected == true
            ? Colors.orangeAccent.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 1, color: selected == true ? TColors.primary : TColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwText,
          ),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: TColors.darkGrey),
          ),
        ],
      ),
    );
  }
}
