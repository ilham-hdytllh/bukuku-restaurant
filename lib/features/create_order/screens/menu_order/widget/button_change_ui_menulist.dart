import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ButtonChangeUIMenuList extends StatelessWidget {
  const ButtonChangeUIMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        height: TSizes.inputFieldHeight - 10,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            enableFeedback: false,
            animationDuration: Duration.zero,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            foregroundColor: TColors.light,
            backgroundColor: TColors.black,
            disabledForegroundColor: TColors.darkGrey,
            disabledBackgroundColor: TColors.buttonDisabled,
            side: const BorderSide(color: TColors.black),
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.buttonHeight - 10, horizontal: 20),
            textStyle: const TextStyle(
                fontSize: 14,
                color: TColors.textWhite,
                fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
          ),
          icon: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                controller.wrapOrNo.value
                    ? Iconsax.category_2
                    : Iconsax.setting_4_copy,
                color: TColors.white,
                size: 18,
              ),
            ),
          ),
          onPressed: () =>
              controller.wrapOrNo.value = !controller.wrapOrNo.value,
          label: const Text(""),
        ),
      ),
    );
  }
}
