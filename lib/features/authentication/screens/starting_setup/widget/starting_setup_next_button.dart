import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class StartingSetupNextButton extends StatelessWidget {
  const StartingSetupNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TSizes.inputFieldHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => StartingSetupController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            foregroundColor: TColors.white,
            backgroundColor: TColors.primary),
        child: Text(
          "next".tr,
        ),
      ),
    );
  }
}
