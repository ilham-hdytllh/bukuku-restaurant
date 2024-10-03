import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class PercentOrAmount extends StatelessWidget {
  const PercentOrAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrderController());
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            contentPadding: const EdgeInsets.only(right: 5, left: 5),
            title: Text(
              "Rp",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            value: "rp",
            groupValue: controller.discountType.value,
            activeColor: TColors.primary,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              controller.discountType.value = "rp";
              Get.back();
            },
          ),
          RadioListTile(
            contentPadding: const EdgeInsets.only(right: 5, left: 5),
            title: Text(
              "%",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            value: "%",
            groupValue: controller.discountType.value,
            activeColor: TColors.primary,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              controller.discountType.value = "%";
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
