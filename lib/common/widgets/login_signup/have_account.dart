import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/screens/login/login.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class THaveAccount extends StatelessWidget {
  const THaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "haveAccount".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
            onPressed: () => Get.to(() => const LoginScreen()),
            child: Text(
              "loginNow".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: TColors.primary),
            ))
      ],
    );
  }
}
