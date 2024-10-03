import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/screens/signup/signup.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class TNotHaveAccount extends StatelessWidget {
  const TNotHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "notHaveAccount".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
            onPressed: () => Get.to(() => const SignupScreen()),
            child: Text(
              "signUpNow".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: TColors.primary),
            ))
      ],
    );
  }
}
