import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/screens/select_account/select_account.dart';
import 'package:restaurant_bukuku/features/navigation/controllers/appbar/appbar_controller.dart';
import 'package:restaurant_bukuku/features/setting/screens/setting_screen.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/divider/horizontal_divider.dart';
import 'package:restaurant_bukuku/utils/divider/vertical_divider.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final appbarController = Get.put(AppBarController());
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      appbarController.appBarTitle.value,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: TColors.primary),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Iconsax.notification_copy,
                    size: TSizes.iconMd,
                    color: TColors.darkGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Iconsax.message_question_copy,
                    size: TSizes.iconMd,
                    color: TColors.darkGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.setting_2_copy,
                      size: TSizes.iconMd,
                      color: TColors.darkGrey,
                    ),
                    onPressed: () => Get.to(const SettingScreen(),
                        duration: const Duration(milliseconds: 500),
                        transition: Transition.fade),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const CustomVerticalDivider(),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(const SelectAccountScreen()),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Iconsax.user_tick_copy,
                          size: TSizes.iconMd,
                          color: TColors.darkGrey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Text(
                                appbarController.employeNameActive.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: TColors.black,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      appbarController.branchNameActive.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: TColors.darkerGrey),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Iconsax.arrow_down_1_copy,
                                    size: TSizes.iconMd - 5,
                                    color: TColors.darkGrey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CustomHorizontalDivider(),
        ],
      ),
    );
  }
}
