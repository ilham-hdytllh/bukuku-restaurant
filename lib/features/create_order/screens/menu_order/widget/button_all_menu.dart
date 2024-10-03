import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ButtonAllMenu extends StatelessWidget {
  const ButtonAllMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Flexible(
      flex: 2,
      child: SizedBox(
        width: double.infinity,
        height: TSizes.inputFieldHeight - 10,
        child: Obx(
          () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              enableFeedback: false,
              animationDuration: Duration.zero,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              backgroundColor: (controller.selectedFilter.value == "all" &&
                      controller.selectedCategoryFilter.value.isEmpty)
                  ? TColors.primary
                  : TColors.softGrey,
              side: BorderSide(
                  color: (controller.selectedFilter.value == "all" &&
                          controller.selectedCategoryFilter.value.isEmpty)
                      ? TColors.primary
                      : TColors.softGrey),
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.buttonHeight - 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
            ),
            onPressed: () {
              controller.selectedFilter.value = "all";
              controller.selectedCategoryFilter.value = "";
              controller.orderBySearch();
            },
            child: Text(
              "Semua",
              style: TextStyle(
                  fontSize: 14,
                  color: (controller.selectedFilter.value == "all" &&
                          controller.selectedCategoryFilter.value.isEmpty)
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
