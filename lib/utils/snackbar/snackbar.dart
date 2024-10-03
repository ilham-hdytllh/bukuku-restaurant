import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class CustomSnackbar {
  static hideSnackbar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.darkGrey.withOpacity(0.9)
                : TColors.grey.withOpacity(0.9),
          ),
          child: Center(
              child: Text(
            message,
            style: Theme.of(Get.context!).textTheme.labelLarge,
          )),
        ),
      ),
    );
  }

  static successSnackbar({required title, message = ""}) {
    Get.snackbar(title, message,
        isDismissible: true,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 20, left: 250, right: 250),
        borderRadius: 10,
        colorText: TColors.white,
        backgroundColor: TColors.success,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
        icon: const Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static warningSnackbar({required title, message = ""}) {
    Get.snackbar(title, message,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 20, left: 250, right: 250),
        borderRadius: 10,
        isDismissible: true,
        colorText: TColors.white,
        backgroundColor: TColors.warning,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
        icon: const Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static errorSnackbar({required title, message = ""}) {
    Get.snackbar(title, message,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 20, left: 250, right: 250),
        borderRadius: 10,
        isDismissible: true,
        colorText: TColors.white,
        backgroundColor: TColors.error,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
        icon: const Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }
}
