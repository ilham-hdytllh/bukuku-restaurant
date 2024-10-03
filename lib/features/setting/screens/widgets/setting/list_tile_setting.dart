import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ListTileSetting extends StatelessWidget {
  const ListTileSetting({super.key, required this.title, required this.onTap});
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: TSizes.spaceBtwItems),
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: TColors.grey),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
