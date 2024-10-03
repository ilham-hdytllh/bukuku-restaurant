import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/locale_dropdown/content_dialog.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/features/system/controller/translation/translation_controller.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class THeaderAuthPage extends StatelessWidget {
  const THeaderAuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 7)),
                  onPressed: () {
                    if (THelperFunctions.screenWidth() > 600) {
                      CustomDialog.tabletDialog(
                          (THelperFunctions.screenWidth() * 0.5), () {
                        TranslationController.instance.setLocale();
                        // ignore: invalid_use_of_protected_member
                        Get.find<TranslationController>().refresh();
                      }, "save".tr, "selectLanguage".tr, ContentDialog(), true);
                    } else {
                      CustomDialog.mobileDialog(
                        THelperFunctions.screenWidth() * 0.5,
                        THelperFunctions.screenHeight() * 0.3,
                        () {
                          TranslationController.instance.setLocale();
                          // ignore: invalid_use_of_protected_member
                          Get.find<TranslationController>().refresh();
                        },
                        "save".tr,
                        "selectLanguage".tr,
                        ContentDialog(),
                      );
                    }
                  },
                  child: Get.locale!.languageCode == "id"
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: TSizes.iconMd,
                              width: TSizes.iconMd,
                              image: AssetImage(TImages.indonesia),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems - 12,
                            ),
                            Text(
                              "bahasaID".tr,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems - 12,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_outlined,
                              size: TSizes.iconMd,
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: TSizes.iconMd,
                              width: TSizes.iconMd,
                              image: AssetImage(TImages.english),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems - 12,
                            ),
                            Text(
                              "englishEN".tr,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems - 12,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_outlined,
                              size: TSizes.iconMd,
                            )
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        Image(
          height: 80,
          image: AssetImage(
            dark ? TImages.darkAppLogo : TImages.lightAppLogo,
          ),
        ),
      ],
    );
  }
}
