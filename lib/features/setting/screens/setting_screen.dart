import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/common/widgets/locale_dropdown/content_dialog.dart';
import 'package:restaurant_bukuku/features/setting/screens/widgets/setting/list_tile_setting.dart';
import 'package:restaurant_bukuku/features/system/controller/translation/translation_controller.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/features/navigation/screens/app_bar/custom_appbar.dart';
import 'package:restaurant_bukuku/common/widgets/custom_back_button/custom_back_button.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    final translationController = Get.put(TranslationController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            // Custom Appbar
            const CustomAppbar(),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: TColors.softGrey,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 90,
                            right: 40,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                                CustomBackButton(onTap: () => Get.back()),
                                const SizedBox(
                                  height: TSizes.spaceBtwText + 10,
                                ),
                                Container(
                                  color: TColors.white,
                                  child: Column(
                                    children: [
                                      ListTileSetting(
                                        title: "Profile",
                                        onTap: () =>
                                            settingController.changeIndex(0),
                                      ),
                                      settingController.employeRoleActive
                                                      .value ==
                                                  "master" ||
                                              settingController
                                                      .employeRoleActive
                                                      .value ==
                                                  "headbranch"
                                          ? ListTileSetting(
                                              title: "About Restaurant",
                                              onTap: () => settingController
                                                  .changeIndex(1),
                                            )
                                          : const SizedBox(),
                                      settingController.employeRoleActive
                                                      .value ==
                                                  "master" ||
                                              settingController
                                                      .employeRoleActive
                                                      .value ==
                                                  "headbranch"
                                          ? ListTileSetting(
                                              title: "About Outlet",
                                              onTap: () => settingController
                                                  .changeIndex(2),
                                            )
                                          : const SizedBox(),
                                      settingController.employeRoleActive
                                                      .value ==
                                                  "master" ||
                                              settingController
                                                      .employeRoleActive
                                                      .value ==
                                                  "headbranch"
                                          ? ListTileSetting(
                                              title: "Print",
                                              onTap: () => settingController
                                                  .changeIndex(3),
                                            )
                                          : const SizedBox(),
                                      ListTileSetting(
                                        title: "PIN & Password",
                                        onTap: () =>
                                            settingController.changeIndex(4),
                                      ),
                                      settingController.employeRoleActive
                                                      .value ==
                                                  "master" ||
                                              settingController
                                                      .employeRoleActive
                                                      .value ==
                                                  "headbranch"
                                          ? ListTileSetting(
                                              title: "Reset Data",
                                              onTap: () => settingController
                                                  .changeIndex(5),
                                            )
                                          : const SizedBox(),
                                      settingController.employeRoleActive
                                                      .value ==
                                                  "master" ||
                                              settingController
                                                      .employeRoleActive
                                                      .value ==
                                                  "headbranch"
                                          ? ListTileSetting(
                                              title: "Receipt Settings",
                                              onTap: () => settingController
                                                  .changeIndex(6),
                                            )
                                          : const SizedBox(),
                                      ListTileSetting(
                                        title: "Privacy Policy",
                                        onTap: () =>
                                            settingController.changeIndex(7),
                                      ),
                                      ListTileSetting(
                                        title: "Term & Conditions",
                                        onTap: () =>
                                            settingController.changeIndex(8),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (THelperFunctions.screenWidth() >
                                              600) {
                                            CustomDialog.tabletDialog(
                                                (THelperFunctions
                                                        .screenWidth() *
                                                    0.5), () {
                                              translationController.setLocale();
                                              // ignore: invalid_use_of_protected_member
                                              translationController.refresh();
                                            }, "save".tr, "selectLanguage".tr,
                                                ContentDialog(), true);
                                          } else {
                                            CustomDialog.mobileDialog(
                                              THelperFunctions.screenWidth() *
                                                  0.5,
                                              THelperFunctions.screenHeight() *
                                                  0.3,
                                              () {
                                                translationController
                                                    .setLocale();
                                                // ignore: invalid_use_of_protected_member
                                                translationController.refresh();
                                              },
                                              "save".tr,
                                              "selectLanguage".tr,
                                              ContentDialog(),
                                            );
                                          }
                                        },
                                        child: Get.locale!.languageCode == "id"
                                            ? Container(
                                                height: 50,
                                                width: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: TSizes.spaceBtwItems),
                                                decoration: const BoxDecoration(
                                                  color: TColors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: TColors.grey),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Language",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Image(
                                                            height:
                                                                TSizes.iconMd,
                                                            width:
                                                                TSizes.iconMd,
                                                            image: AssetImage(
                                                                TImages
                                                                    .indonesia),
                                                          ),
                                                          const SizedBox(
                                                            width: TSizes
                                                                    .spaceBtwItems -
                                                                10,
                                                          ),
                                                          Text(
                                                            "ID",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                          const SizedBox(
                                                            width: TSizes
                                                                    .spaceBtwItems -
                                                                12,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down_outlined,
                                                            size: TSizes.iconMd,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height: 50,
                                                width: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: TSizes.spaceBtwItems),
                                                decoration: const BoxDecoration(
                                                  color: TColors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: TColors.grey),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Language",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Image(
                                                            height:
                                                                TSizes.iconMd,
                                                            width:
                                                                TSizes.iconMd,
                                                            image: AssetImage(
                                                                TImages
                                                                    .english),
                                                          ),
                                                          const SizedBox(
                                                            width: TSizes
                                                                    .spaceBtwItems -
                                                                10,
                                                          ),
                                                          Text(
                                                            "EN",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                          const SizedBox(
                                                            width: TSizes
                                                                    .spaceBtwItems -
                                                                12,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down_outlined,
                                                            size: TSizes.iconMd,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: TColors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: TColors.grey),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "appName".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const SizedBox(
                                          height: TSizes.spaceBtwInputFields,
                                        ),
                                        Text(
                                          "appVersion".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    Obx(
                      () => settingController.viewContentInAccordanceIndex(),
                    ),
                    const SizedBox(
                      width: 115,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
