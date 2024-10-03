import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class ChangeNameProfile extends StatelessWidget {
  const ChangeNameProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Form(
      key: settingController.formNameKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          RichText(
              text: TextSpan(
                  text: "Name",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: ' *',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary))
              ])),
          const SizedBox(
            height: TSizes.spaceBtwInputFields - 8,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: settingController.profileName,
            validator: (value) => TValidator.validateEmptyText("Name", value),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
