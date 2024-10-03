import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

// ignore: must_be_immutable
class EmptyItem extends StatelessWidget {
  EmptyItem(
      {super.key,
      required this.text,
      this.desciption,
      required this.picture,
      this.width,
      this.fit});
  String text;
  String? desciption;
  Widget picture;
  double? width = 150;
  BoxFit? fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          picture,
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            desciption ?? "",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: TColors.dark.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
