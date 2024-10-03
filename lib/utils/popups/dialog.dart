import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';

class CustomDialog {
  static mobileDialog(double width, double height, Function onPressed,
      String titleButton, String headerText, Widget content) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: Get.context!,
        builder: (context) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: TColors.white,
              border: Border.all(color: TColors.borderSecondary),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 5,
                  left: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(headerText),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Iconsax.close_circle,
                          size: TSizes.iconMd,
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: 120,
                  right: 0,
                  left: 0,
                  child: Divider(
                    thickness: 1,
                    color: TColors.darkGrey,
                  ),
                ),
                Positioned(
                  top: 135,
                  bottom: 120,
                  right: 10,
                  left: 10,
                  child: SingleChildScrollView(
                    child: content,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  left: 10,
                  child: SizedBox(
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton(
                      onPressed: onPressed(),
                      child: Text(titleButton),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static tabletDialog(double width, Function onPressed, String titleButton,
      String headerText, Widget content, bool withButton,
      [bool isLoading = false]) {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            backgroundColor: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.black
                : TColors.white,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            titlePadding: EdgeInsets.zero,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        headerText,
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Iconsax.close_square,
                          size: TSizes.iconMd,
                          color: TColors.darkGrey,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: THelperFunctions.isDarkMode(Get.context!) ? 1 : 1,
                  color: THelperFunctions.isDarkMode(Get.context!)
                      ? TColors.darkContainer
                      : TColors.darkGrey.withOpacity(0.6),
                ),
              ],
            ),
            content: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: content,
                )),
            actions: [
              withButton
                  ? SizedBox(
                      width: double.infinity,
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: TColors.light,
                          backgroundColor: TColors.primary,
                          disabledForegroundColor: TColors.darkGrey,
                          disabledBackgroundColor: TColors.buttonDisabled,
                          side: const BorderSide(color: TColors.primary),
                          padding: const EdgeInsets.symmetric(
                              vertical: TSizes.buttonHeight - 10,
                              horizontal: 20),
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: TColors.textWhite,
                              fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TSizes.buttonRadius)),
                        ),
                        onPressed: () {
                          onPressed();
                        },
                        child: isLoading == false
                            ? Text(titleButton)
                            : TLoader.loaderButton(),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        });
  }

  static confirmationDialog(
      double width,
      Function onPressed,
      String titleButton,
      String headerText,
      Widget content,
      IconData iconData,
      Color bgColor,
      [bool isLoading = false]) {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            backgroundColor: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.black
                : TColors.white,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            titlePadding: EdgeInsets.zero,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        headerText,
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Iconsax.close_square,
                          size: TSizes.iconMd,
                          color: TColors.darkGrey,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: THelperFunctions.isDarkMode(Get.context!) ? 1 : 1,
                  color: THelperFunctions.isDarkMode(Get.context!)
                      ? TColors.darkContainer
                      : TColors.darkGrey.withOpacity(0.6),
                ),
              ],
            ),
            content: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: content,
                )),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: TColors.light,
                          backgroundColor: bgColor,
                          disabledForegroundColor: TColors.darkGrey,
                          disabledBackgroundColor: TColors.buttonDisabled,
                          side: BorderSide(color: bgColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: TSizes.buttonHeight - 10,
                              horizontal: 20),
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: TColors.textWhite,
                              fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TSizes.buttonRadius)),
                        ),
                        onPressed: () {
                          onPressed();
                        },
                        icon: Icon(iconData),
                        label: isLoading == false
                            ? Text(titleButton)
                            : TLoader.loaderButton(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: TSizes.inputFieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: TColors.light,
                          backgroundColor: TColors.dark,
                          disabledForegroundColor: TColors.black,
                          disabledBackgroundColor: TColors.buttonDisabled,
                          side: const BorderSide(color: TColors.black),
                          padding: const EdgeInsets.symmetric(
                              vertical: TSizes.buttonHeight - 10,
                              horizontal: 20),
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: TColors.textWhite,
                              fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TSizes.buttonRadius)),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("cancel".tr),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
