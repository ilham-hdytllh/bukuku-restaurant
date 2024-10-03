import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class OnBoardingNextButtonTablet extends StatelessWidget {
  const OnBoardingNextButtonTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
      child: SizedBox(
        height: TSizes.inputFieldHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              foregroundColor: TColors.white,
              backgroundColor: TColors.primary),
          child: Text(
            "next".tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: TColors.white),
          ),
        ),
      ),
    );
  }
}
