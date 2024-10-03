import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/device/device_utility.dart';

class OnBoardingSkipMobile extends StatelessWidget {
  const OnBoardingSkipMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: GestureDetector(
        onTap: () => OnBoardingController.instance.skipPage(),
        child: const Text("Skip"),
      ),
    );
  }
}
