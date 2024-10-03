import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';

class TFullScreenLoader {
  // Start loader
  static void openLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) => WillPopScope(
              onWillPop: () async => true,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: THelperFunctions.isDarkMode(Get.context!)
                    ? TColors.dark
                    : TColors.white,
                content: Container(
                  width: 100,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Lottie.asset(
                            TImages.loader,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Please wait...",
                            style: Theme.of(Get.context!).textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  // Stop loader
  static stopLoading() {
    Navigator.of(Get.context!).pop();
  }
}
