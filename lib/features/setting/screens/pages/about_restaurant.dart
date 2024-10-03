import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/features/setting/screens/pages/component/restaurant_data.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class AboutRestaurantPage extends StatelessWidget {
  const AboutRestaurantPage({super.key});

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
              "About Restaurant",
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
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              decoration: const BoxDecoration(
                color: TColors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: TColors.grey),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(
                    () => settingController.merchantLogoActive.value.isNotEmpty
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(settingController
                                      .merchantLogoActive.value),
                                  fit: BoxFit.cover),
                              border: Border.all(width: 1, color: TColors.grey),
                              borderRadius: BorderRadius.circular(
                                  TSizes.inputFieldRadius),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: TColors.grey),
                              borderRadius: BorderRadius.circular(
                                  TSizes.inputFieldRadius),
                            ),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: TColors.darkGrey,
                                borderRadius: BorderRadius.circular(
                                    TSizes.inputFieldRadius),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          settingController.merchantNameActive.value,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Obx(
                        () => Text(
                          settingController.merchantCurrencyActive.value,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.darkGrey),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      settingController.setMerchantDataToController();
                      CustomDialog.tabletDialog(
                        (THelperFunctions.screenWidth() * 0.5),
                        () async {
                          await settingController.updateMerchantData();
                        },
                        "save".tr,
                        "About Restaurant",
                        const RestaurantData(),
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
            ),
          ],
        ),
      ),
    );
  }
}
