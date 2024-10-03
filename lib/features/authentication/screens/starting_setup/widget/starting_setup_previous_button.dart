import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class StartingSetupPreviousButton extends StatelessWidget {
  const StartingSetupPreviousButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: TextButton(
          onPressed: () => StartingSetupController.instance.previousPage(),
          child: Text(
            "previous".tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: TColors.primary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
