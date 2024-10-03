import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/system/controller/translation/translation_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ContentDialog extends StatelessWidget {
  ContentDialog({super.key});

  final List<String> localeList = ['id', 'en'];
  final TranslationController transController =
      Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: localeList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => RadioListTile(
            contentPadding: const EdgeInsets.only(right: 5, left: 5),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  height: TSizes.iconMd,
                  width: TSizes.iconMd,
                  image: AssetImage(localeList[index] == 'id'
                      ? TImages.indonesia
                      : TImages.english),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  localeList[index] == 'id' ? "bahasaID".tr : "englishEN".tr,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            value: localeList[index],
            groupValue: transController.selectedOption.value,
            activeColor: TColors.primary,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              transController.setSelectedOption(value!);
            },
          ),
        );
      },
    );
  }
}
