import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/login/login_controller.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final isDark = THelperFunctions.isDarkMode(Get.context!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: TSizes.inputFieldHeight,
          width: THelperFunctions.screenWidth() < 900
              ? THelperFunctions.screenWidth() * 0.6
              : THelperFunctions.screenWidth() * 0.45,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.buttonHeight - 10, horizontal: 20),
            ),
            onPressed: () => controller.googleSignIn(),
            icon: Image(
              height: TSizes.iconMd,
              width: TSizes.iconMd,
              image: AssetImage(isDark ? TImages.googleDark : TImages.google),
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "signinWithGoogle".tr,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
