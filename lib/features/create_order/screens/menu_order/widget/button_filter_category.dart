import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/category_content/category_content.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';

class ButtonFilteredCategory extends StatelessWidget {
  const ButtonFilteredCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Flexible(
      flex: 2,
      child: SizedBox(
        width: double.infinity,
        height: TSizes.inputFieldHeight - 10,
        child: Obx(
          () => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              enableFeedback: false,
              animationDuration: Duration.zero,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              backgroundColor:
                  controller.selectedCategoryFilter.value.isNotEmpty
                      ? TColors.primary
                      : TColors.softGrey,
              side: BorderSide(
                color: controller.selectedCategoryFilter.value.isNotEmpty
                    ? TColors.primary
                    : TColors.softGrey,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.buttonHeight - 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
            ),
            onPressed: () => CustomDialog.tabletDialog(
              (THelperFunctions.screenWidth() * 0.5),
              () {
                Get.back();
              },
              "select".tr,
              "Category",
              CategoryContent(
                text: controller.selectedCategoryFilter,
                onChanged: controller.orderBySearch,
              ),
              false,
            ),
            icon: Icon(
              Iconsax.setting_4_copy,
              color: controller.selectedCategoryFilter.value.isNotEmpty
                  ? TColors.white
                  : TColors.darkGrey,
              size: 18,
            ),
            label: Text(
              "Kategori",
              style: TextStyle(
                  fontSize: 14,
                  color: controller.selectedCategoryFilter.value.isNotEmpty
                      ? TColors.white
                      : TColors.darkGrey,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
