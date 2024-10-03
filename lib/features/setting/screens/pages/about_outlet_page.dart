import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/component/branch_address.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/component/branch_update.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class AboutOutletPage extends StatelessWidget {
  const AboutOutletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Flexible(
      flex: 3,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Text(
              "About Branch",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            const Divider(
              thickness: 5,
              color: TColors.primary,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              decoration: const BoxDecoration(
                color: TColors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: TColors.grey),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Branch Profile",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {
                          settingController.setBranchDataToController(
                              settingController.branchNameActive.value,
                              settingController.branchPhoneActive.value);
                          CustomDialog.tabletDialog(
                            (THelperFunctions.screenWidth() * 0.5),
                            () async {
                              await settingController.updateBranchData();
                            },
                            "save".tr,
                            "About Branch",
                            const BranchProfileUpdate(),
                            true,
                            settingController.isLoading.value,
                          );
                        },
                        icon: const Icon(
                          Iconsax.edit_2_copy,
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields - 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Branch Name",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: TColors.darkGrey),
                      ),
                      Obx(
                        () => Text(
                          settingController.branchNameActive.value
                              .capitalizeSingle(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Branch Phone Number",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: TColors.darkGrey),
                      ),
                      Obx(
                        () => Text(
                          settingController.branchPhoneActive.value.isNotEmpty
                              ? "${settingController.branchDialCodeActive.value}${settingController.branchPhoneActive.value}"
                              : "-",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields + 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            const Divider(
              thickness: 5,
              color: TColors.primary,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              decoration: const BoxDecoration(
                color: TColors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: TColors.grey),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Branch Address",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {
                          CustomDialog.tabletDialog(
                            (THelperFunctions.screenWidth() * 0.5),
                            () async {
                              await settingController.updateBranchAddress();
                            },
                            "save".tr,
                            "Branch Address",
                            const BranchAddress(),
                            true,
                            settingController.isLoading.value,
                          );
                        },
                        icon: const Icon(
                          Iconsax.edit_2_copy,
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields - 5,
                  ),
                  Obx(
                    () => Text(
                      settingController.branchAddressActive.value,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields + 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
