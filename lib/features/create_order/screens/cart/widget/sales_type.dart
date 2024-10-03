import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/create_order/controllers/create_order_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';

class SalesType extends StatelessWidget {
  const SalesType({super.key});

  @override
  Widget build(BuildContext context) {
    final createOrderController = Get.put(CreateOrderController());
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: createOrderController.salesType.length,
        itemBuilder: (context, index) => Obx(
          () => RadioListTile(
            contentPadding: const EdgeInsets.only(right: 5, left: 5),
            title: Text(
              createOrderController.salesType[index]["salesType"],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              createOrderController.salesType[index]["description"],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            value: createOrderController.salesType[index]["salesType"],
            groupValue: createOrderController.selectedSalesType.value,
            activeColor: TColors.primary,
            onChanged: (value) => createOrderController.setSalesType(
                createOrderController.salesType[index]["salesType"]),
          ),
        ),
      ),
    );
  }
}
