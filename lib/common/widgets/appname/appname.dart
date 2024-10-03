import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "appName".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        Text(
          "appVersion".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
