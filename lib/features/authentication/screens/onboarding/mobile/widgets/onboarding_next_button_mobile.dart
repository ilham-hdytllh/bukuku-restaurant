import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/device/device_utility.dart';

class OnBoardingNextButtonMobile extends StatelessWidget {
  const OnBoardingNextButtonMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        left: 15,
        right: 15,
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
            ),
          ),
        ));
  }
}
